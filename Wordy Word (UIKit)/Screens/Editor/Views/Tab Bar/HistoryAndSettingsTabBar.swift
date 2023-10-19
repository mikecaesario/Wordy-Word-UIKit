//
//  HistoryAndSettingsTabBar.swift
//  Wordy Word (UIKit)
//
//  Created by Michael Caesario on 08/05/23.
//

import UIKit

protocol HistoryAndSettingsTabBarDelegate: AnyObject {
    func didTappedHistoryButton()
    func didTappedSettingsButton()
}

class HistoryAndSettingsTabBar: UIView {

    private let historyButton = TabBarButton()
    private let settingsButton = TabBarButton()
    
    weak var delegate: HistoryAndSettingsTabBarDelegate?
    
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
        
        self.layer.cornerRadius = self.layer.frame.height / 2.0
        self.layer.masksToBounds = true
        addBlurBackground()
    }
    
    private func configureView() {
        
        self.backgroundColor = .clear
  
        let config = UIImage.SymbolConfiguration(pointSize: 26, weight: .light, scale: .medium)
        
        historyButton.setImage(UIImage(systemName: "book", withConfiguration: config), for: .normal)
        historyButton.addTarget(self, action: #selector(callForHistorySegue), for: .touchUpInside)
        historyButton.backgroundColor = .background.thirtiary
        
        settingsButton.setImage(UIImage(systemName: "gearshape", withConfiguration: config), for: .normal)
        settingsButton.addTarget(self, action: #selector(callForSettingsSegue), for: .touchUpInside)
        settingsButton.backgroundColor = .button.secondary
    }
    
    private func addBlurBackground() {
        
        let blurEffect = UIBlurEffect(style: .systemUltraThinMaterialLight)
        let blurBackground = UIVisualEffectView(effect: blurEffect)
        blurBackground.translatesAutoresizingMaskIntoConstraints = false
        blurBackground.frame = self.bounds
        self.insertSubview(blurBackground, at: 0)
    }
    
    private func layoutUI() {
        
        historyButton.translatesAutoresizingMaskIntoConstraints = false
        settingsButton.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubviews([historyButton, settingsButton])
                
        let padding = 5.0
        let multiplier = 0.9
        
        NSLayoutConstraint.activate([
        
            historyButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            historyButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            historyButton.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: multiplier),
            historyButton.widthAnchor.constraint(equalTo: self.heightAnchor, multiplier: multiplier),

            settingsButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            settingsButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            settingsButton.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: multiplier),
            settingsButton.widthAnchor.constraint(equalTo: self.heightAnchor, multiplier: multiplier),
        ])
    }
}

extension HistoryAndSettingsTabBar {
    
    @objc private func callForHistorySegue() { delegate?.didTappedHistoryButton() }
    
    @objc private func callForSettingsSegue() { delegate?.didTappedSettingsButton() }
}
