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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = (self.layer.frame.height / 2)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        self.titleLabel?.font = UIFont(name: .fonts.poppinsMedium, size: 16)
        self.clipsToBounds = true
        self.titleLabel?.adjustsFontSizeToFitWidth = true
        self.titleLabel?.minimumScaleFactor = 1.0
        self.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
        self.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
    }
}
