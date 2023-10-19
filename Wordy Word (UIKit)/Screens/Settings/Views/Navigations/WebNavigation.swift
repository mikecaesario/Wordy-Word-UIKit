//
//  WebNavigation.swift
//  Wordy Word (UIKit)
//
//  Created by Michael Caesario on 21/09/23.
//

import Foundation
import UIKit

protocol WebNavigationDelegate: AnyObject {
    
    func didFinishTappingCloseButton()
    func didFinishTappingBackButton()
    func didFinishTappingForwardButton()
}

final class WebNavigation: UIView {
    
    private let gradientBackground = CAGradientLayer()
    private let closeButton = NavigationBarCircleButton()
    private let backButton = NavigationBarCircleButton()
    private let forwardButton = NavigationBarCircleButton()

    weak var delegate: WebNavigationDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
        layoutUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setGradientBackgroundFrame()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setGradientBackgroundFrame() {
        gradientBackground.frame = self.bounds
    }
    
    private func configureView() {
        
        self.backgroundColor = .clear
        
        closeButton.setImageForButton(imageName: "xmark", size: 22)
        backButton.setImageForButton(imageName: "chevron.left", size: 22)
        forwardButton.setImageForButton(imageName: "chevron.right", size: 22)
        
        backButton.tintColor = .text.grey
        backButton.isEnabled = false
        
        forwardButton.tintColor = .text.grey
        forwardButton.isEnabled = false
        
        closeButton.addTarget(self, action: #selector(didTappedCloseButton), for: .touchUpInside)
        backButton.addTarget(self, action: #selector(didTappedBackButton), for: .touchUpInside)
        forwardButton.addTarget(self, action: #selector(didTappedForwardButton), for: .touchUpInside)
        
        if let color = UIColor.background.primary?.cgColor {

            gradientBackground.colors = [UIColor.clear.cgColor, color]
        }

        gradientBackground.locations = [0.05, 0.6]
    }
    
    private func layoutUI() {
        
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.translatesAutoresizingMaskIntoConstraints = false
        forwardButton.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubviews([closeButton, backButton, forwardButton])
        self.layer.insertSublayer(gradientBackground, at: 0)
        
        let padding = 16.0
        let bottomPadding = -10.0
        let forwardAndBackSpacing = 10.0
        let multiplierValue = 0.6
        
        NSLayoutConstraint.activate([
        
            closeButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            closeButton.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: bottomPadding),
            closeButton.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: multiplierValue),
            closeButton.widthAnchor.constraint(equalTo: self.heightAnchor, multiplier: multiplierValue),
            
            forwardButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            forwardButton.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: bottomPadding),
            forwardButton.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: multiplierValue),
            forwardButton.widthAnchor.constraint(equalTo: self.heightAnchor, multiplier: multiplierValue),
            
            backButton.trailingAnchor.constraint(equalTo: forwardButton.leadingAnchor, constant: -forwardAndBackSpacing),
            backButton.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: bottomPadding),
            backButton.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: multiplierValue),
            backButton.widthAnchor.constraint(equalTo: self.heightAnchor, multiplier: multiplierValue)

        ])
    }
    
    @objc private func didTappedCloseButton() {
        delegate?.didFinishTappingCloseButton()
    }
    
    @objc private func didTappedBackButton() {
        delegate?.didFinishTappingBackButton()
    }
    
    @objc private func didTappedForwardButton() {
        delegate?.didFinishTappingForwardButton()
    }
    
    func isBackButtonEnabled(isEnabled: Bool) {
        
        if isEnabled {
            backButton.tintColor = .text.white
            backButton.isEnabled = true
        } else {
            backButton.tintColor = .text.grey
            backButton.isEnabled = false
        }
    }
    
    func isForwardButtonEnabled(isEnabled: Bool) {
        
        if isEnabled {
            forwardButton.tintColor = .text.white
            forwardButton.isEnabled = true
        } else {
            forwardButton.tintColor = .text.grey
            forwardButton.isEnabled = false
        }
    }
}
