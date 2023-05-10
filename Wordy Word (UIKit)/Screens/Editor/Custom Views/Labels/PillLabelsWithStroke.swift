//
//  PillLabelsWithStroke.swift
//  WordyWord (UIKit)
//
//  Created by Michael Caesario on 30/04/23.
//

import UIKit

class PillLabelsWithStroke: UILabel {

    var insets = UIEdgeInsets.zero
    
    override func drawText(in rect: CGRect) {
        let insetsRect = rect.inset(by: insets)
        super.drawText(in: insetsRect)
        configure()
    }
    
    override var intrinsicContentSize: CGSize {
        var size = super.intrinsicContentSize
        size.width += insets.left + insets.right
        size.height += insets.top + insets.bottom
        return size
    }
    
    private func configure() {
        textAlignment = .center
        minimumScaleFactor = 0.7
        font = UIFont(name: "Poppins-Medium", size: 16)
        layer.cornerRadius = self.frame.height / 2
        layer.borderWidth = 1.0
        clipsToBounds = true
        backgroundColor = .clear
    }
}