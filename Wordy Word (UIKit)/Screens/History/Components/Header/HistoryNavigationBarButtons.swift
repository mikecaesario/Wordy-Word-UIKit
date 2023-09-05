//
//  DetailedHistoryNavigationBarButtons.swift
//  Wordy Word (UIKit)
//
//  Created by Michael Caesario on 28/08/23.
//

import UIKit

protocol DetailedHistoryNavigationBarButtonsProtocol: AnyObject {
    func didFinishedTappingBackButton()
    func didFinishTappingCopyToClipboardButton()
}

class DetailedHistoryNavigationBarButtons: UIView {
    
    private let backButton = NavigationBarCircleButton()
    private let copyButton = NavigationBarCircleButton()
    private let gradientBackground = CAGradientLayer()
    
    weak var delegate: DetailedHistoryNavigationBarButtonsProtocol?
    
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
        
        setupBoundsForGradientBackground()
    }
    
    private func setupBoundsForGradientBackground() {
        
        gradientBackground.frame = self.bounds
    }
    
    private func configureView() {
        
        backButton.setImageForButton(imageName: "chevron.left", size: 20)
        copyButton.setImageForButton(imageName: "doc.on.doc", size: 20)
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        copyButton.addTarget(self, action: #selector(copyTextToClipboard), for: .touchUpInside)
        
        if let color = UIColor.background.primary?.cgColor {
            gradientBackground.colors = [color, UIColor.clear.cgColor]
        }
        
        gradientBackground.locations = [0.6, 1.0]
    }
    
    private func layoutUI() {
        
        backButton.translatesAutoresizingMaskIntoConstraints = false
        copyButton.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(backButton)
        self.addSubview(copyButton)
        self.layer.insertSublayer(gradientBackground, at: 0)
        
        let padding = 18.0
        let multiplier = 0.55
        
        NSLayoutConstraint.activate([
            
            backButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            backButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            backButton.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: multiplier),
            backButton.widthAnchor.constraint(equalTo: self.heightAnchor, multiplier: multiplier),
            
            copyButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            copyButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            copyButton.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: multiplier),
            copyButton.widthAnchor.constraint(equalTo: self.heightAnchor, multiplier: multiplier)
        ])
    }
    
    @objc private func backButtonTapped() {
        delegate?.didFinishedTappingBackButton()
    }
    
    @objc private func copyTextToClipboard() {
        delegate?.didFinishTappingCopyToClipboardButton()
    }
    
    func animateCopyButtonForSuccess() {
        
        UIView.transition(with: copyButton, duration: 1.0, options: .transitionCrossDissolve) { [weak self] in
            self?.copyButton.backgroundColor = .button.primary
            self?.copyButton.tintColor = .text.black
            self?.copyButton.setImageForButton(imageName: "checkmark", size: 20)
        } completion: { _ in
            
            UIView.transition(with: self.copyButton, duration: 0.6, options: .transitionCrossDissolve) { [weak self] in
                
                if let self = self {
                    self.copyButton.backgroundColor = .background.thirtiary
                    self.copyButton.tintColor = .text.white
                    self.copyButton.setImageForButton(imageName: "doc.on.doc", size: 20)
                }
            }
        }
    }
}
