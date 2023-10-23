//
//  EditingStyleEnum.swift
//  Wordy Word (UIKit)
//
//  Created by Michael Caesario on 16/05/23.
//

import Foundation

public enum EditingStyleEnum: CaseIterable {
    
    /// Possible editing cases
    case capitalize, title, upper, lower, replace, remove, reverse
    
    /// Return string title of the selected enum case
    var titleName: String {
        
        switch self {
        case .capitalize:
           return "Capitalize"
        case .title:
           return "Title"
        case .upper:
            return "Uppercase"
        case .lower:
            return "Lowercase"
        case .replace:
            return "Replace"
        case .remove:
            return "Remove"
        case .reverse:
            return "Reverse"
        }
    }
    
    /// Return SF Symbols glyph name of the selected enum case
    var imageName: String {
        
        switch self {
        case .capitalize:
            "textformat"
        case .title:
            "textformat.alt"
        case .upper:
            "textformat.size.larger"
        case .lower:
            "textformat.abc"
        case .replace:
            "character.cursor.ibeam"
        case .remove:
            "xmark"
        case .reverse:
            "arrow.left.arrow.right"
        }
    }
}
