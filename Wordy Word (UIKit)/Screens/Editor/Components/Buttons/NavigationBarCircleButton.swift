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
        backgroundColor = .background.thirtiary
        tintColor = .text.white
        layer.masksToBounds = true
    }
    
    func setImageForButton(imageName: String, size: CGFloat) {
        let config = UIImage.SymbolConfiguration(pointSize: size, weight: .light, scale: .small)
        setImage(UIImage(systemName: imageName, withConfiguration: config), for: .normal)
    }
}
