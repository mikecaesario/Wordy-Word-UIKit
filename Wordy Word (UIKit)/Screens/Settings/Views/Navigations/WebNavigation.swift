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
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
    }
    
    private func layoutUI() {
        
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.translatesAutoresizingMaskIntoConstraints = false
        forwardButton.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubviews([closeButton, backButton, forwardButton])
        
        let padding = 16.0
        let forwardAndBackSpacing = 10.0
        let multiplierValue = 0.8
        
        NSLayoutConstraint.activate([
        
            closeButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            closeButton.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: <#T##CGFloat#>),
            closeButton.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: multiplierValue),
            closeButton.widthAnchor.constraint(equalTo: self.heightAnchor, multiplier: multiplierValue),
            
            forwardButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            forwardButton.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: <#T##CGFloat#>),
            forwardButton.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: multiplierValue),
            forwardButton.widthAnchor.constraint(equalTo: self.heightAnchor, multiplier: multiplierValue),
            
            backButton.trailingAnchor.constraint(equalTo: forwardButton.leadingAnchor, constant: -forwardAndBackSpacing),
            backButton.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: <#T##CGFloat#>),
            backButton.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: multiplierValue),
            backButton.widthAnchor.constraint(equalTo: self.heightAnchor, multiplier: multiplierValue)

        ])
    }
    
    @objc private func didTappedCloseButton() {
        print("CLOSE BUTTON TAPPED")
        delegate?.didFinishTappingCloseButton()
    }
    
    @objc private func didTappedBackButton() {
        print("BACK BUTTON TAPPED")

        delegate?.didFinishTappingBackButton()
    }
    
    @objc private func didTappedForwardButton() {
        print("FORWARD BUTTON TAPPED")

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
