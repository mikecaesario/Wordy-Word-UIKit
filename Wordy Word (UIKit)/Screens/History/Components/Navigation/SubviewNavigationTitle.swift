//
//  HistoryNavigationTitle.swift
//  Wordy Word (UIKit)
//
//  Created by Michael Caesario on 20/08/23.
//

import UIKit

class SubviewNavigationTitle: UIView {
    
    private let grabberPill = UIView()
    private let navigationLabel = UILabel()
    private let gradientBackground = CAGradientLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        prepareView()
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
        
        grabberPill.layer.cornerRadius = (grabberPill.frame.height / 2.0)
        grabberPill.clipsToBounds = true
    }
    
    private func prepareView() {
        
        navigationLabel.textColor = .text.white
        navigationLabel.textAlignment = .left
        navigationLabel.font = UIFont(name: .fonts.poppinsSemiBold, size: 30)
        
        grabberPill.backgroundColor = .miscellaneous.grabber
        
        if let color = UIColor.background.primary?.cgColor {
            
            gradientBackground.colors = [color, UIColor.clear.cgColor]
        }
        
        gradientBackground.locations = [0.6, 1.0]
    }
    
    private func layoutUI() {
        
        grabberPill.translatesAutoresizingMaskIntoConstraints = false
        navigationLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(grabberPill)
        self.addSubview(navigationLabel)
        self.layer.insertSublayer(gradientBackground, at: 0)
        
        let padding = 18.0
        
        NSLayoutConstraint.activate([
        
            grabberPill.topAnchor.constraint(equalTo: self.topAnchor, constant: 15),
            grabberPill.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            grabberPill.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.2),
            grabberPill.heightAnchor.constraint(equalToConstant: 5),
            
            navigationLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            navigationLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    
    func setNavigationTitle(title: String) {
        navigationLabel.text = title
    }
}
