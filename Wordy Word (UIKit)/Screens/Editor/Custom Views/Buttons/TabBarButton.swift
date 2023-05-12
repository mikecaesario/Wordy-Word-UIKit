//
//  TabBarButton.swift
//  Wordy Word (UIKit)
//
//  Created by Michael Caesario on 11/05/23.
//

import UIKit

class TabBarButton: UIButton {

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
        tintColor = .text.white
        layer.masksToBounds = true
    }
}
