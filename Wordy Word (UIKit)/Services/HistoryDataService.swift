//
//  HistoryDataService.swift
//  Wordy Word (UIKit)
//
//  Created by Michael Caesario on 16/05/23.
//

import Foundation

protocol HistoryDataServiceProtocol {
    
    var fileName: String { get }
    func fetchHistoryItemsFromJSON() -> [HistoryItems]
    func saveHistoryItemsToJSON(history: [HistoryItems]?)
    func didFinishEditingNowAppendingHistoryItem(history: [HistoryItems], editingText: String, editingResult: String, editingStyle: EditingStyleEnum) -> [HistoryItems]
}

class HistoryDataService: HistoryDataServiceProtocol {
    
    internal let fileName = "historyItems.json"
    
    func fetchHistoryItemsFromJSON() -> [HistoryItems] {
        
        guard let fileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent(fileName) else { return [] }
        
        if FileManager.default.fileExists(atPath: fileURL.path) {
            
            do {
                
                let data = try Data(contentsOf: fileURL)
                let decoder = JSONDecoder()
                let items = try decoder.decode([HistoryItems].self, from: data)
                print(items.count)
                return items
            } catch {
                
                return []
            }
            
        } else {
            
            return []
        }
    }
    
    func saveHistoryItemsToJSON(history: [HistoryItems]?) {
        
        guard let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first, let history = history else { return }
        let fileUrl = url.appendingPathComponent(fileName)
        
        let items = Array(history.suffix(25))
        
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(items)
            try data.write(to: fileUrl)
            print("SAVING ITEM TO JSON")
        } catch {
            print("ERROR SAVING HISTORY: \(error.localizedDescription)")
        }
    }
    
    func didFinishEditingNowAppendingHistoryItem(history: [HistoryItems], editingText: String, editingResult: String, editingStyle: EditingStyleEnum) -> [HistoryItems] {
                
        var history = history
        let currentDate = Date()
        
        if let matchingDate = history.firstIndex(where: { currentDate.isSameDayAs(otherDate: $0.date) }) {
            
            if let undeditedItemsAlreadyExistsInTheArrayIndex = history[matchingDate].items.firstIndex(where: { $0.uneditedItem == editingText }) {
                
                let newHistoryResult = EditHistoryItemResults(timeStamp: currentDate, style: editingStyle.rawValue, result: editingResult)
                history[matchingDate].items[undeditedItemsAlreadyExistsInTheArrayIndex].result.append(newHistoryResult)
                print("ADDED RESULT \(history[matchingDate].items[undeditedItemsAlreadyExistsInTheArrayIndex].result.count)")
                return history
            } else {
                
                let newHistoryResult = EditHistoryItemResults(timeStamp: currentDate, style: editingStyle.rawValue, result: editingResult)
                let newEditHistoryItem = EditHistoryItem(uneditedItem: editingText, result: [newHistoryResult])
                history[matchingDate].items.append(newEditHistoryItem)
                print("ADDED ITEMS \(history[matchingDate].items.count)")
                return history
            }
            
        } else {
            
            let newHistoryResult = EditHistoryItemResults(timeStamp: currentDate, style: editingStyle.rawValue, result: editingResult)
            let newEditHistoryItem = EditHistoryItem(uneditedItem: editingText, result: [newHistoryResult])
            let newHistoryItems = HistoryItems(date: currentDate, items: [newEditHistoryItem])
            history.append(newHistoryItems)
            print("ADDED HISTORY ITEMS \(history.count)")
            return history
        }
    }
}
