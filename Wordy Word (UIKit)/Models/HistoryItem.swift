//
//  EditHistoryItem.swift
//  Wordy Word (UIKit)
//
//  Created by Michael Caesario on 16/05/23.
//

import Foundation

struct HistoryItems: Codable {
    let date: Date
    var items: [EditHistoryItem]
}

struct EditHistoryItem: Codable {
    let uneditedItem: String
    var result: [HistoryItemResults]
}

struct HistoryItemResults: Codable {
    let timeStamp: Date
    let style: String
    let result: String
}
