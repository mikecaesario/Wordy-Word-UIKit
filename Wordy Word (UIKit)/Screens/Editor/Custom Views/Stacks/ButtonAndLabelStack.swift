//
//  ButtonAndLabelStack.swift
//  WordyWord (UIKit)
//
//  Created by Michael Caesario on 30/04/23.
//

import UIKit

class ButtonAndLabelStack: UIStackView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        axis = .horizontal
        spacing = 5
        distribution = .fill
        alignment = .leading
        layoutMargins = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        isLayoutMarginsRelativeArrangement = true
    }
}
