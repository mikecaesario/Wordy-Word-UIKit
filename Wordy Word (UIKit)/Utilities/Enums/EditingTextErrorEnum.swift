//  
//  EditingTextErrorEnum.swift
//  Wordy Word (UIKit)
//
//  Created with ❤️‍🔥 by Michael Caesario on 14/12/23.
//  Copyright © 2023 Michael Caesario. All rights reserved.
// 
//  Website: https://mikecaesario.app
//  GitHub: https://github.com/mikecaesario
//  LinkedIn: https://www.linkedin.com/in/mikecaesario/
//

import Foundation

enum EditingTextErrorEnum: Error {
    
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
