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
    
    func capitalizeSentences() -> String {
        
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
    
    func paragraphsCount() -> Int {

        let paragraphs = self.components(separatedBy: "\n\n")
        return paragraphs.count
    }
}

extension String {
    
    struct fonts {
        
        static let poppinsMedium = "Poppins-Medium"
        static let poppinsSemiBold = "Poppins-SemiBold"
    }
}
