//
//  DetailedHistoryNavigationFooter.swift
//  Wordy Word (UIKit)
//
//  Created by Michael Caesario on 02/09/23.
//

import UIKit

class DetailedHistoryNavigationFooter: UIView {

    private let timeStampLabel = UILabel()
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
        
        editingStyleLabel.font = UIFont(name: .fonts.poppinsSemiBold, size: 22)
        editingStyleLabel.textColor = .text.white
        editingStyleLabel.textAlignment = .right
        editingStyleLabel.numberOfLines = 1
        editingStyleLabel.minimumScaleFactor = 0.7
        
        if let color = UIColor.background.primary?.cgColor {
            gradientBackground.colors = [UIColor.clear.cgColor, color]
        }
        
        gradientBackground.locations = [0.05, 0.35]
    }
    
    private func layoutUI() {
        
        timeStampLabel.translatesAutoresizingMaskIntoConstraints = false
        editingStyleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubviews([timeStampLabel, editingStyleLabel])
        self.layer.insertSublayer(gradientBackground, at: 0)
        
        let padding = 20.0
        
        NSLayoutConstraint.activate([
        
            timeStampLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            timeStampLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),

            editingStyleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            editingStyleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    
    func setupLabel(time: Date, style: String) {
        
        timeStampLabel.text = DateFormatter.formattedHourFromDate.string(from: time)
        editingStyleLabel.text = style
    }
}
