//
//  HistoryTableViewCell.swift
//  Wordy Word (UIKit)
//
//  Created by Michael Caesario on 10/07/23.
//

import UIKit

class HistoryTableViewCell: UITableViewCell {

    private let backgroundContainer = UIView()
    private let historyPreviewText = UITextView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        prepareCell()
        layoutUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func prepareCell() {
        
        self.backgroundColor = .clear
                
        let padding = 16.0
        
        backgroundContainer.backgroundColor = .background.thirtiary
        backgroundContainer.layer.cornerRadius = (self.frame.height / 1.5)
        backgroundContainer.clipsToBounds = true
        
        historyPreviewText.font = UIFont(name: .fonts.poppinsMedium, size: 17)
        historyPreviewText.textColor = .text.white
        historyPreviewText.isEditable = false
        historyPreviewText.isSelectable = false
        historyPreviewText.isScrollEnabled = false
        historyPreviewText.textContainer.maximumNumberOfLines = 7
        historyPreviewText.textContainer.lineBreakMode = .byTruncatingTail
        historyPreviewText.backgroundColor = .background.secondary
        historyPreviewText.textContainerInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
    }
    
    private func layoutUI() {
        
        backgroundContainer.translatesAutoresizingMaskIntoConstraints = false
        historyPreviewText.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubviews([backgroundContainer, historyPreviewText])
        
        backgroundContainer.layer.zPosition = -1
        
        let horizontalPadding = 16.0
        let verticalPadding = 8.0
        
        NSLayoutConstraint.activate([
        
            historyPreviewText.topAnchor.constraint(equalTo: self.topAnchor, constant: verticalPadding),
            historyPreviewText.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: horizontalPadding),
            historyPreviewText.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -verticalPadding),
            historyPreviewText.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -horizontalPadding),
        ])
    }
    
    func setupCell(histroyItem: EditHistoryItem) {
        
        historyPreviewText.text = histroyItem.uneditedItem
    }
}
