//
//  TextEditorService.swift
//  Wordy Word (UIKit)
//
//  Created by Michael Caesario on 12/09/23.
//

import Foundation

protocol TextEditorManagerProtocol {
    func startEditText(text: String?, editingStyle: EditingStyleEnum?, remove: [String]?, find: String?, replace: String?) throws -> String
}

class TextEditorManager: TextEditorManagerProtocol {
    
    func startEditText(text: String?, editingStyle: EditingStyleEnum?, remove: [String]?, find: String?, replace: String?) throws -> String {
        
        guard let text = text, text != "" else { throw EditingTextError.noTextInput }

        guard let style = editingStyle else { throw EditingTextError.editingStyleIsNotSelected}
                
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
            
            guard let find = find else { throw EditingTextError.findTextIsEmpty }
            
            guard let replace = replace else { throw EditingTextError.replaceTextIsEmpty }
            
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
    
    case noTextInput, editingStyleIsNotSelected, findTextIsEmpty, replaceTextIsEmpty, removeIsEmpty
    
    var localizedDescription: String {
        switch self {
            
        case .noTextInput:
            return NSLocalizedString("There are no text available to be edited", comment: "")

        case .editingStyleIsNotSelected:
            return NSLocalizedString("Editing style hasn't been selected", comment: "")

        case .findTextIsEmpty:
            return NSLocalizedString("Enter find text before continuing", comment: "")
            
        case .replaceTextIsEmpty:
            return NSLocalizedString("Enter replacing text before continuing", comment: "")

        case .removeIsEmpty:
            return NSLocalizedString("Remove character is empty", comment: "")

        }
    }
}
