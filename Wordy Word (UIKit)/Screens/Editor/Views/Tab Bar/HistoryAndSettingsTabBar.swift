//
//  HistoryAndSettingsTabBar.swift
//  Wordy Word (UIKit)
//
//  Created by Michael Caesario on 08/05/23.
//

import UIKit

protocol HistoryAndSettingsTabBarDelegate: AnyObject {
    
}

class HistoryAndSettingsTabBar: UIView {

    private let buttonStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 10
        stack.distribution = .fill
        stack.alignment = .center
        return stack
    }()
    
    private let historyButton: UIButton = {
        let button = UIButton()
        let config = UIImage.SymbolConfiguration(pointSize: 30, weight: .light, scale: .medium)
        button.setImage(UIImage(systemName: "book", withConfiguration: config), for: .normal)
        button.tintColor = .text.black
        button.backgroundColor = .button.primary
        return button
    }()
    
    private let settingsButton: UIButton = {
        let button = UIButton()
        let config = UIImage.SymbolConfiguration(pointSize: 30, weight: .light, scale: .medium)
        button.setImage(UIImage(systemName: "gearshape", withConfiguration: config), for: .normal)
        button.tintColor = .text.black
        button.backgroundColor = .button.primary
        return button
    }()
    
    weak var delegate: HistoryAndSettingsTabBarDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureView()
        layoutUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView() {
        
        self.backgroundColor = .gray
        self.layer.cornerRadius = 45
        self.layer.masksToBounds = true
        
        historyButton.layer.cornerRadius = self.frame.height / 2
        settingsButton.layer.cornerRadius = self.frame.height / 2
        
        historyButton.addTarget(self, action: #selector(didTappedHistoryButton), for: .touchUpInside)
        settingsButton.addTarget(self, action: #selector(didTappedSettingsButton), for: .touchUpInside)
    }
    
    private func layoutUI() {
        
        buttonStack.translatesAutoresizingMaskIntoConstraints = false
        historyButton.translatesAutoresizingMaskIntoConstraints = false
        settingsButton.translatesAutoresizingMaskIntoConstraints = false
        
        buttonStack.insertArrangedSubview(historyButton, at: 0)
        buttonStack.insertArrangedSubview(settingsButton, at: 1)
        
        self.addSubview(buttonStack)
        
        let buttonHeightAndWidth = self.frame.width / 2.2
        
        NSLayoutConstraint.activate([
        
            buttonStack.topAnchor.constraint(equalTo: self.topAnchor),
            buttonStack.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            buttonStack.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            buttonStack.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            historyButton.heightAnchor.constraint(equalToConstant: buttonHeightAndWidth),
            historyButton.widthAnchor.constraint(equalToConstant: buttonHeightAndWidth),
            
            settingsButton.heightAnchor.constraint(equalToConstant: buttonHeightAndWidth),
            settingsButton.widthAnchor.constraint(equalToConstant: buttonHeightAndWidth)
        ])
    }
}

extension HistoryAndSettingsTabBar {
    
    @objc private func didTappedHistoryButton() { }
    
    @objc private func didTappedSettingsButton() { }
}
