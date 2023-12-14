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
        
        guard let text = text, text != "" else { throw EditingTextErrorEnum.noTextInput }

        guard let style = editingStyle else { throw EditingTextErrorEnum.editingStyleIsNotSelected}
                
        var result = ""
        
        switch style {
        case .capitalize:
            result = text.capitalized
        case .title:
            result = text.titlecased()
        case .upper:
            result = text.uppercased()
        case .lower:
            result = text.lowercased()
        case .replace:
            
            guard let find = find else { throw EditingTextErrorEnum.findTextIsEmpty }
            
            guard let replace = replace else { throw EditingTextErrorEnum.replaceTextIsEmpty }
            
            result = text.replaceCharacter(find: find, replaceWith: replace)
        case .remove:
            
            guard let remove = remove else { throw EditingTextErrorEnum.removeIsEmpty }

            result = text.removeCharacter(remove: remove)
        case .reverse:
            result = String(text.reversed())
        }
        
        return result
    }
}
