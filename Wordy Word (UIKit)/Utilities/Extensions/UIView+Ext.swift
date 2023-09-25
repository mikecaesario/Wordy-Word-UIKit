//
//  UIView+Ext.swift
//  Wordy Word (UIKit)
//
//  Created by Michael Caesario on 25/09/23.
//

import UIKit

extension UIView {
    
    func addSubviews(_ views: [UIView]) {
        
        for i in views {
            self.addSubview(i)
        }
    }
}
