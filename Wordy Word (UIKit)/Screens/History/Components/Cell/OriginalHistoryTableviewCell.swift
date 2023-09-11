//
//  OriginalHistoryTableviewCell.swift
//  Wordy Word (UIKit)
//
//  Created by Michael Caesario on 11/09/23.
//

import Foundation
import UIKit

class OriginalHistoryTableviewCell: UITableViewCell {
    
    private let originalHistoryText = UITextView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureCell()
        layoutUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureCell() {
        
        self.backgroundColor = .clear
        
        originalHistoryText.backgroundColor = .clear
        originalHistoryText.textColor = .text.white
        originalHistoryText.font = UIFont(name: .fonts.poppinsMedium, size: 22)
        originalHistoryText.textAlignment = .left
        originalHistoryText.textContainer.maximumNumberOfLines = 10
        originalHistoryText.textContainer.lineBreakMode = .byTruncatingTail
        originalHistoryText.isEditable = false
        originalHistoryText.isSelectable = false
        originalHistoryText.isScrollEnabled = false
        originalHistoryText.textContainerInset = UIEdgeInsets(top: 10, left: 16, bottom: 10, right: 16)
    }
    
    private func layoutUI() {
        
        originalHistoryText.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(originalHistoryText)
                
        NSLayoutConstraint.activate([
            
            originalHistoryText.topAnchor.constraint(equalTo: self.topAnchor),
            originalHistoryText.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            originalHistoryText.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            originalHistoryText.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    func setupCell(originalHistoryItem: String) {
        originalHistoryText.text = originalHistoryItem
    }
}

