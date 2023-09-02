//
//  DetailedHistoryNavigationFooter.swift
//  Wordy Word (UIKit)
//
//  Created by Michael Caesario on 02/09/23.
//

import UIKit

class DetailedHistoryNavigationFooter: UIView {

    private let timeStampLabel = UILabel()
    private let originalTextLabel = UILabel()
    private let editingStyleLabel = UILabel()
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
        
        timeStampLabel.font = UIFont(name: .fonts.poppinsSemiBold, size: 22)
        timeStampLabel.textColor = .text.white
        timeStampLabel.textAlignment = .left
        timeStampLabel.numberOfLines = 1
        timeStampLabel.minimumScaleFactor = 0.7
        
        originalTextLabel.text = "Original"
        originalTextLabel.font = UIFont(name: .fonts.poppinsSemiBold, size: 22)
        originalTextLabel.textColor = .text.white
        originalTextLabel.textAlignment = .center
        originalTextLabel.numberOfLines = 1
        originalTextLabel.minimumScaleFactor = 0.7
        
        editingStyleLabel.font = UIFont(name: .fonts.poppinsSemiBold, size: 22)
        editingStyleLabel.textColor = .text.white
        editingStyleLabel.textAlignment = .right
        editingStyleLabel.numberOfLines = 1
        editingStyleLabel.minimumScaleFactor = 0.7
        
        if let color = UIColor.background.primary?.cgColor {
            gradientBackground.colors = [UIColor.clear.cgColor, color]
        }
        
        gradientBackground.locations = [0.1, 0.5]
    }
    
    private func layoutUI() {
        
        timeStampLabel.translatesAutoresizingMaskIntoConstraints = false
        originalTextLabel.translatesAutoresizingMaskIntoConstraints = false
        editingStyleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(timeStampLabel)
        self.addSubview(originalTextLabel)
        self.addSubview(editingStyleLabel)
        self.layer.insertSublayer(gradientBackground, at: 0)
        
        let padding = 16.0
        
        NSLayoutConstraint.activate([
        
            timeStampLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            timeStampLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            originalTextLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            originalTextLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            editingStyleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            editingStyleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
   
    func setupFooterLabels(time: String?, style: String?) {
        
        if let time = time, let style = style {
            
            originalTextLabel.isHidden = true
            
            timeStampLabel.text = time
            editingStyleLabel.text = style
        } else {
            
            timeStampLabel.isHidden = true
            timeStampLabel.isHidden = true
            
            timeStampLabel.text = ""
            editingStyleLabel.text = ""
        }
    }
}
