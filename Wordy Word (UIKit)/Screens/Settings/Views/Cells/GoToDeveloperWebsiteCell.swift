//
//  GoToDeveloperWebsiteCell.swift
//  Wordy Word (UIKit)
//
//  Created by Michael Caesario on 21/09/23.
//

import Foundation
import UIKit

class GoToDeveloperWebsiteCell: UITableViewCell {
    
    private let backgroundContainer = UIView()
    private let developerLabel = UILabel()
    private let developerNameLabel = UILabel()
    
    private let devName = "Michael Caesario"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureCell()
        layoutUI()
        print("DEV CELL CONFIGURED")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureCell() {
        
        self.backgroundColor = .clear
        
        backgroundContainer.backgroundColor = .background.thirtiary
        backgroundContainer.layer.cornerRadius = (self.frame.height / 2.0)
        backgroundContainer.clipsToBounds = true
        
        developerLabel.text = "Developer"
        developerLabel.textColor = .text.white
        developerLabel.textAlignment = .left
        developerLabel.numberOfLines = 1
        developerLabel.minimumScaleFactor = 0.8
        developerLabel.font = UIFont(name: .fonts.poppinsMedium, size: 20)
        
        developerNameLabel.text = devName
        developerNameLabel.textColor = .text.white
        developerNameLabel.textAlignment = .left
        developerNameLabel.numberOfLines = 1
        developerNameLabel.minimumScaleFactor = 0.8
        developerNameLabel.font = UIFont(name: .fonts.poppinsSemiBold, size: 20)
    }
    
    private func layoutUI() {
        
        backgroundContainer.translatesAutoresizingMaskIntoConstraints = false
        developerLabel.translatesAutoresizingMaskIntoConstraints = false
        developerNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let views = [backgroundContainer, developerLabel, developerNameLabel]
        
        contentView.addSubviews(views)
        backgroundContainer.layer.zPosition = -1
        
        let padding = 16.0
        let verticalPadding = 10.0
        
        NSLayoutConstraint.activate([
        
            backgroundContainer.topAnchor.constraint(equalTo: contentView.topAnchor, constant: verticalPadding),
            backgroundContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            backgroundContainer.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -verticalPadding),
            backgroundContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            
            developerLabel.leadingAnchor.constraint(equalTo: backgroundContainer.leadingAnchor, constant: padding),
            developerLabel.centerYAnchor.constraint(equalTo: backgroundContainer.centerYAnchor),
            developerLabel.heightAnchor.constraint(equalToConstant: 50),
            
            developerNameLabel.trailingAnchor.constraint(equalTo: backgroundContainer.trailingAnchor, constant: -padding),
            developerNameLabel.centerYAnchor.constraint(equalTo: backgroundContainer.centerYAnchor),
            developerNameLabel.heightAnchor.constraint(equalToConstant: 50)

        ])
    }
}
