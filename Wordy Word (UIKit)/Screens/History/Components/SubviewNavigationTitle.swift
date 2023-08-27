//
//  HistoryNavigationTitle.swift
//  Wordy Word (UIKit)
//
//  Created by Michael Caesario on 20/08/23.
//

import UIKit

class SubviewNavigationTitle: UIView {

    let navigationLabel = UILabel()
    let gradientBackground = CAGradientLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        prepareView()
        layoutUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        applyGradientBackground()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func applyGradientBackground() {
        
        gradientBackground.frame = self.bounds
    }
    
    private func prepareView() {
        
        navigationLabel.textColor = .text.white
        navigationLabel.textAlignment = .left
        navigationLabel.font = UIFont(name: .fonts.poppinsSemiBold, size: 30)
        
        if let color = UIColor.background.primary?.cgColor {
            
            gradientBackground.colors = [color, UIColor.clear.cgColor]
        }
        
        gradientBackground.locations = [0.6, 1.0]
    }
    
    private func layoutUI() {
        
        navigationLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(navigationLabel)
        self.layer.insertSublayer(gradientBackground, at: 0)
        
        let padding = 18.0
        
        NSLayoutConstraint.activate([
        
            navigationLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            navigationLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    
    func setNavigationTitle(title: String) {
        navigationLabel.text = title
    }
}
