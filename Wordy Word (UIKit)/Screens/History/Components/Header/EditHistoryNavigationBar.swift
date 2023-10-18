//
//  EditHistoryNavigationBar.swift
//  Wordy Word (UIKit)
//
//  Created by Michael Caesario on 11/09/23.
//

import Foundation
import UIKit

protocol EditHistoryNavigationBarDelegate: AnyObject {
    func didFinishTappingBackButton()
}

class EditHistoryNavigationBar: UIView {
    
    private let backButton = NavigationBarCircleButton()
    private let gradientBackground = CAGradientLayer()
    
    weak var delegate: EditHistoryNavigationBarDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureView()
        layoutUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setGradientBackgroundAndAddCornerRadius()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setGradientBackgroundAndAddCornerRadius() {
        
        gradientBackground.frame = self.bounds
    }
    
    private func configureView() {
        
        self.backgroundColor = .clear
        
        backButton.setImageForButton(imageName: "chevron.left", size: 20)
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        
        if let color = UIColor.background.primary?.cgColor {
            
            gradientBackground.colors = [color, UIColor.clear.cgColor]
        }
        
        gradientBackground.locations = [0.6, 1.0]
    }
    
    private func layoutUI() {
        
        backButton.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(backButton)
        self.layer.insertSublayer(gradientBackground, at: 0)
        
        let padding = 18.0
        let multiplier = 0.55
        
        NSLayoutConstraint.activate([

            backButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            backButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            backButton.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: multiplier),
            backButton.widthAnchor.constraint(equalTo: self.heightAnchor, multiplier: multiplier)
        ])
    }
    
    @objc private func backButtonTapped() {
        delegate?.didFinishTappingBackButton()
    }
}

