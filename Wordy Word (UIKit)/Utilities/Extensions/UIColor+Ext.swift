//
//  Color+Ext.swift
//  WordyWord (UIKit)
//
//  Created by Michael Caesario on 25/02/23.
//

import UIKit

extension UIColor {
    
    struct background {
        static let primary = UIColor(named: "PrimaryBackgroundColor")
        static let secondary = UIColor(named: "SecondaryBackgoundColor")
        static let thirtiary = UIColor(named: "ThirtiaryBackgroundColor")
        static let quarternary = UIColor(named: "QuarternaryBackgroundColor")
    }
    
    struct accent {
        static let secondary = UIColor(named: "SecondaryAccentColor")
    }
    
    struct button {
        static let primary = UIColor(named: "ButtonPrimaryColor")
        static let secondary = UIColor(named: "ButtonSecondaryColor")
        static let strokeLight = UIColor(named: "ButtonStrokeLightColor")
        static let strokeDark = UIColor(named: "ButtonStrokeDarkColor")
        static let copy = UIColor(named: "CopyButtonColor")
        static let paste = UIColor(named: "PasteButtonColor")
        static let cancel = UIColor(named: "CancelButtonColor")
    }
    
    struct text {
        static let editor = UIColor(named: "EditorTextColor")
        static let white = UIColor(named: "WhiteTextColor")
        static let placeholder = UIColor(named: "PlaceholderTextColor")
        static let black = UIColor(named: "BlackTextColor")
        static let grey = UIColor(named: "GreyTextColor")
    }
    
    struct miscellaneous {
        static let grabber = UIColor(named: "GrabberBackgroundColor")
    }
}
