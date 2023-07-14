//
//  HistoryTableViewCell.swift
//  Wordy Word (UIKit)
//
//  Created by Michael Caesario on 10/07/23.
//

import UIKit

class HistoryTableViewCell: UITableViewCell {

    private let historyPreviewText = UITextView()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        prepareCell()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    private func prepareCell() {
        
        self.backgroundColor = .background.secondary
        self.layer.cornerRadius = 20
        self.layer.masksToBounds = true
        
        historyPreviewText.font = UIFont(name: <#T##String#>, size: <#T##CGFloat#>)
        historyPreviewText.textColor = .text.white
    }
    
    private func layoutUI() {
        
        historyPreviewText.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(historyPreviewText)
        
        let padding = 16.0
        
        NSLayoutConstraint.activate([
        
            historyPreviewText.topAnchor.constraint(equalTo: self.topAnchor, constant: padding),
            historyPreviewText.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            historyPreviewText.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -padding),
            historyPreviewText.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
        ])
    }
    
    func setupCell(histroyItem: EditHistoryItem) {
        
        historyPreviewText.text = histroyItem.uneditedItem
    }
}
