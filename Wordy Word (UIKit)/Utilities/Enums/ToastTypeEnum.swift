//  
//  ToastTypeEnum.swift
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

public enum ToastTypeEnum {
    case paste, copy, error
    
    var symbol: String {
        
        switch self {
        case .paste:
            "exclamationmark.triangle.fill"
        case .copy:
            "checkmark"
        case .error:
            "exclamationmark.triangle.fill"
        }
    }
    
    var message: String {
        
        switch self {
        case .paste:
            "There are no item to be pasted from the clipboard"
        case .copy:
            "Text has been successfully copied to clipboard"
        case .error:
            "Whoops! Something went wrong, please try again later"
        }
    }
}

