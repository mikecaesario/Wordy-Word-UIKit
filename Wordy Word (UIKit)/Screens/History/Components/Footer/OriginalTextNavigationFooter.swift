//
//  OriginalTextNavigationFooter.swift
//  Wordy Word (UIKit)
//
//  Created by Michael Caesario on 11/09/23.
//

import Foundation
import UIKit

class OriginalTextNavigationFooter: UIView {
    
    private let originalTextLabel = UILabel()
    private let gradientBackground = CAGradientLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureView()
        layoutUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setupGradientBackground()
    }
    
    private func setupGradientBackground() {
        
        gradientBackground.frame = self.bounds
    }
    
    private func configureView() {
        
        self.backgroundColor = .clear
        
        originalTextLabel.text = "Original"
        originalTextLabel.font = UIFont(name: .fonts.poppinsSemiBold, size: 22)
        originalTextLabel.textColor = .text.white
        originalTextLabel.textAlignment = .center
        originalTextLabel.numberOfLines = 1
        originalTextLabel.minimumScaleFactor = 0.7
        
        if let color = UIColor.background.primary?.cgColor {
            gradientBackground.colors = [UIColor.clear.cgColor, color]
        }
        
        gradientBackground.locations = [0.05, 0.35]
    }
    
    private func layoutUI() {
        
        originalTextLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(originalTextLabel)
        self.layer.insertSublayer(gradientBackground, at: 0)
                        
        NSLayoutConstraint.activate([
            
            originalTextLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            originalTextLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
}

