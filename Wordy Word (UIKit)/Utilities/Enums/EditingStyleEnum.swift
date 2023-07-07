//
//  EditingStyleEnum.swift
//  Wordy Word (UIKit)
//
//  Created by Michael Caesario on 16/05/23.
//

import Foundation

enum EditingStyleEnum: String, CaseIterable {
    
    case capitalize = "Capitalize"
    case title = "Title"
    case upper = "Uppercase"
    case lower = "Lowercase"
    case replace = "Replace"
    case remove = "Remove"
    case reverse = "Reverse"
    
    enum EditingStyleEnumImage: String, CaseIterable {
        case capitalize = "textformat"
        case title = "textformat.alt"
        case upper = "textformat.size.larger"
        case lower = "textformat.abc"
        case replace = "character.cursor.ibeam"
        case remove = "xmark"
        case reverse = "arrow.left.arrow.right"
    }
}
