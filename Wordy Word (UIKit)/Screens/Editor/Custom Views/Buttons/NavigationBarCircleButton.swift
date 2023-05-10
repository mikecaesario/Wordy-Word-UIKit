//
//  NavigationBarCircleButton.swift
//  Wordy Word (UIKit)
//
//  Created by Michael Caesario on 03/05/23.
//

import UIKit

class NavigationBarCircleButton: UIButton {

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
        let config = UIImage.SymbolConfiguration(pointSize: 20, weight: .light, scale: .small)
        setImage(UIImage(systemName: "slider.horizontal.3", withConfiguration: config), for: .normal)
        backgroundColor = .background.thirtiary
        tintColor = .text.white
        layer.masksToBounds = true
    }
}