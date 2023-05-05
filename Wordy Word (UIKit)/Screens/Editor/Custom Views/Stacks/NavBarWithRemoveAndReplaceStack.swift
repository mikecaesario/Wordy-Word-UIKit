//
//  NavBarWithRemoveAndReplaceStack.swift
//  Wordy Word (UIKit)
//
//  Created by Michael Caesario on 03/05/23.
//

import UIKit

class NavBarWithRemoveAndReplaceStack: UIStackView {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        axis = .vertical
        alignment = .center
        distribution = .fillProportionally
        spacing = 20
    }
}
