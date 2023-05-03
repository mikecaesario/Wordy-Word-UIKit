//
//  PillButtonImageWithText.swift
//  WordyWord (UIKit)
//
//  Created by Michael Caesario on 30/04/23.
//

import UIKit

class PillButtonImageWithText: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        titleLabel?.font = UIFont(name: "Poppins-Medium", size: 16)
        layer.cornerRadius = 20
        clipsToBounds = true
        titleLabel?.adjustsFontSizeToFitWidth = true
        titleLabel?.minimumScaleFactor = 1.0
    }
}
