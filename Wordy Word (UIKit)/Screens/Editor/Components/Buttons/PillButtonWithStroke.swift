//
//  PillButtonWithStroke.swift
//  Wordy Word (UIKit)
//
//  Created by Michael Caesario on 19/05/23.
//

import UIKit

class PillButtonWithStroke: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = (self.frame.height / 2.0)
    }
    
    private func configure() {
        setTitleColor(.text.grey, for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        layer.borderColor = UIColor.button.strokeLight?.cgColor
        layer.borderWidth = 1.8
    }

}
