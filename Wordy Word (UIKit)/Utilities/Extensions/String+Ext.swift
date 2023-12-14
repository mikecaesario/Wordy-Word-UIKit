//
//  String+Ext.swift
//  Wordy Word (UIKit)
//
//  Created by Michael Caesario on 15/05/23.
//

import Foundation

extension String {
    
    var wordCount: Int {
        
        var count = 0
        let range = startIndex..<endIndex
        
        enumerateSubstrings(in: range, options: [.byWords, .substringNotRequired, .localized], { _, _, _, _ -> () in
            count += 1
        })
        
        return count
    }
    
    var sentenceCount: Int {
        
        let sentences = self.components(separatedBy: ".")
        let trimmedSentences = sentences.map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
        let nonEmptySentences = trimmedSentences.filter { !$0.isEmpty }
        return nonEmptySentences.count
    }
    
    func replaceCharacter(find: String?, replaceWith: String?) -> String {
        
        guard let find = find, let replace = replaceWith else { return "" }
        return self.replacingOccurrences(of: find, with: replace)
    }
    
    func removeCharacter(remove: [String]?) -> String {
        
        guard let remove = remove else { return "" }
        
        var result = self
        
        for i in remove {
            result = result.replacingOccurrences(of: i, with: "")
        }
        
        return result
    }
    
    func capitalizecased() -> String {
        
        let sentences = self.components(separatedBy: ".")
        var capitalizedSentences = [String]()
        
        for sentence in sentences {
            
            let trimmed = sentence.trimmingCharacters(in: .whitespacesAndNewlines)
            
            if !trimmed.isEmpty {
                
                let firstChar = String(trimmed.prefix(1)).capitalized
                let rest = String(trimmed.dropFirst())
                capitalizedSentences.append("\(firstChar)\(rest)")
            }
        }
        
        return capitalizedSentences.joined(separator: ". ")
    }
    
    func titlecased() -> String {
        let commonWords = Set(["and", "as", "but", "for", "if", "nor", "or", "so", "yet",
                               "a", "an", "the", "as", "is", "at", "by", "for", "in", "of", "off",
                               "on", "per", "to", "up", "via"])
        
        let words = self.lowercased().components(separatedBy: " ")
        let capitalizedWords = words.map { word -> String in
            if commonWords.contains(word) {
                return word
            } else {
                return word.prefix(1).capitalized + word.dropFirst()
            }
        }
        
        var result = capitalizedWords.joined(separator: " ")
        
        // Capitalize only the first letter of the first word
        if let firstWord = capitalizedWords.first {
            result = firstWord.prefix(1).capitalized + firstWord.dropFirst() + " " + capitalizedWords.dropFirst().joined(separator: " ")
        }
        
        return result
    }
    
    func paragraphsCount() -> Int {

        let paragraphs = self.components(separatedBy: "\n\n")
        return paragraphs.count
    }
}

extension String {
    
    public struct fonts {
        
        static let poppinsMedium = "Poppins-Medium"
        static let poppinsSemiBold = "Poppins-SemiBold"
    }
    
    public struct userDefaults {
        
        static let maxHistoryDataLimit = "maxHistoryDataLimit"
    }
}
