//
//  NavigationBarLabel.swift
//  Wordy Word (UIKit)
//
//  Created by Michael Caesario on 03/05/23.
//

import UIKit

class NavigationBarLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        textColor = .text.white
        font = UIFont(name: "Poppins-Medium", size: 38)
        textAlignment = .left
    }
}
