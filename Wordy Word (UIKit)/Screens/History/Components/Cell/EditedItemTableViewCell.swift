//
//  EditedItemTableViewCell.swift
//  Wordy Word (UIKit)
//
//  Created by Michael Caesario on 11/09/23.
//

import Foundation
import UIKit

class EditedItemTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "EditedItem-TableView-Cell-Identifier"
    
    private let backgroundContainer = UIView()
    private let editedItemText = UITextView()
    private let timeStampLabel = UILabel()
    private let editingStyleLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureView()
        layoutUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView() {
                
        self.backgroundColor = .clear
        
        backgroundContainer.backgroundColor = .background.thirtiary
        backgroundContainer.layer.cornerRadius = (self.frame.height / 1.5)
        backgroundContainer.layer.masksToBounds = true
        
        editedItemText.backgroundColor = .clear
        editedItemText.font = UIFont(name: .fonts.poppinsMedium, size: 16)
        editedItemText.textColor = .text.white
        editedItemText.textContainer.maximumNumberOfLines = 5
        editedItemText.isEditable = false
        editedItemText.isSelectable = false
        editedItemText.isScrollEnabled = false
        
        timeStampLabel.font = UIFont(name: .fonts.poppinsMedium, size: 12)
        timeStampLabel.textColor = .text.grey
        timeStampLabel.textAlignment = .left
        timeStampLabel.numberOfLines = 1
        
        editingStyleLabel.font = UIFont(name: .fonts.poppinsMedium, size: 12)
        editingStyleLabel.textColor = .text.grey
        editingStyleLabel.textAlignment = .right
        editingStyleLabel.numberOfLines = 1
    }
    
    private func layoutUI() {
        
        backgroundContainer.translatesAutoresizingMaskIntoConstraints = false
        editedItemText.translatesAutoresizingMaskIntoConstraints = false
        timeStampLabel.translatesAutoresizingMaskIntoConstraints = false
        editingStyleLabel.translatesAutoresizingMaskIntoConstraints = false

        self.addSubviews([backgroundContainer, editedItemText, timeStampLabel, editingStyleLabel])
        
        backgroundContainer.layer.zPosition = -1

        let verticalPadding = 10.0
        let padding = 16.0
        
        NSLayoutConstraint.activate([
            
            backgroundContainer.topAnchor.constraint(equalTo: self.topAnchor, constant: verticalPadding),
            backgroundContainer.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            backgroundContainer.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -verticalPadding),
            backgroundContainer.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            
            editedItemText.topAnchor.constraint(equalTo: backgroundContainer.topAnchor, constant: padding),
            editedItemText.leadingAnchor.constraint(equalTo: backgroundContainer.leadingAnchor, constant: padding),
            editedItemText.trailingAnchor.constraint(equalTo: backgroundContainer.trailingAnchor, constant: -padding),
            
            timeStampLabel.topAnchor.constraint(equalTo: editedItemText.bottomAnchor, constant: 5),
            timeStampLabel.leadingAnchor.constraint(equalTo: backgroundContainer.leadingAnchor, constant: padding),
            timeStampLabel.bottomAnchor.constraint(equalTo: backgroundContainer.bottomAnchor, constant: -padding),
            timeStampLabel.heightAnchor.constraint(equalToConstant: 10),
            
            editingStyleLabel.topAnchor.constraint(equalTo: editedItemText.bottomAnchor, constant: 5),
            editingStyleLabel.trailingAnchor.constraint(equalTo: backgroundContainer.trailingAnchor, constant: -padding),
            editingStyleLabel.bottomAnchor.constraint(equalTo: backgroundContainer.bottomAnchor, constant: -padding),
            editingStyleLabel.heightAnchor.constraint(equalToConstant: 10)
        ])
    }
    
    func setupCell(historyItem: EditHistoryItemResults) {
        
        editedItemText.text = historyItem.result
        timeStampLabel.text = DateFormatter.formattedHourFromDate.string(from: historyItem.timeStamp)
        editingStyleLabel.text = historyItem.style
    }
}
