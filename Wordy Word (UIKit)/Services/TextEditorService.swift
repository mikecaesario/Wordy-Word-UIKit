//
//  TextEditorService.swift
//  Wordy Word (UIKit)
//
//  Created by Michael Caesario on 12/09/23.
//

import Foundation

protocol TextEditorServiceProtocol {
    func startEditText(text: String?, editingStyle: EditingStyleEnum?, remove: [String]?, find: String?, replace: String?) throws -> String
}

class TextEditorService: TextEditorServiceProtocol {
    
    func startEditText(text: String?, editingStyle: EditingStyleEnum?, remove: [String]?, find: String?, replace: String?) throws -> String {
        
        guard let text = text, text != "", let style = editingStyle else { throw EditingTextError.textIsEmpty }

        var result = ""
        
        switch style {
        case .capitalize:
            result = text.capitalized
        case .title:
            result = text.capitalizeSentences()
        case .upper:
            result = text.uppercased()
        case .lower:
            result = text.lowercased()
        case .replace:
            
            guard let find = find, let replace = replace else { throw EditingTextError.findOrReplaceIsEmpty }
            
            result = text.replaceCharacter(find: find, replaceWith: replace)
        case .remove:
            
            guard let remove = remove else { throw EditingTextError.removeIsEmpty }

            result = text.removeCharacter(remove: remove)
        case .reverse:
            result = String(text.reversed())
        }
        
        return result
    }
}

enum EditingTextError: Error {
    case noTextInput, textIsEmpty, editingStyleIsNotSelected, findOrReplaceIsEmpty, removeIsEmpty
}
