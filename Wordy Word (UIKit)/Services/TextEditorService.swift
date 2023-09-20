//
//  TextEditorService.swift
//  Wordy Word (UIKit)
//
//  Created by Michael Caesario on 12/09/23.
//

import Foundation

protocol TextEditorServiceProtocol {
    func startEditText(text: String?, editingStyle: EditingStyleEnum?, remove: [String]?, find: String?, replace: String?) -> String
}

class TextEditorService: TextEditorServiceProtocol {
    func startEditText(text: String?, editingStyle: EditingStyleEnum?, remove: [String]?, find: String?, replace: String?) -> String {
        return ""
    }
    
   
    
    
}
