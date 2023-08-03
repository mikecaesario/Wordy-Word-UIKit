//
//  DetailedHistoryTableViewCell.swift
//  Wordy Word (UIKit)
//
//  Created by Michael Caesario on 27/07/23.
//

import UIKit

class DetailedHistoryTableViewCell: UITableViewCell {

    private let detailedHistoryItemText = UITextView()
    private let historyItemTimeStampLabel = UILabel()
    private let historyEditingStyleLabel = UILabel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        prepareCell()
        layoutUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

    private func prepareCell() {
        
        self.backgroundColor = .background.primary
        
        detailedHistoryItemText.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        detailedHistoryItemText.textColor = .text.white
        detailedHistoryItemText.isEditable = false
        detailedHistoryItemText.isSelectable = false
        detailedHistoryItemText.isScrollEnabled = false
        detailedHistoryItemText.textContainer.maximumNumberOfLines = 5
        detailedHistoryItemText.textContainer.lineBreakMode = .byTruncatingTail
        
        historyItemTimeStampLabel.font = UIFont.systemFont(ofSize: 11, weight: .regular)
        historyItemTimeStampLabel.textColor = .text.grey
        
        historyEditingStyleLabel.font = UIFont.systemFont(ofSize: 11, weight: .regular)
        historyEditingStyleLabel.textColor = .text.grey
    }
    
    private func layoutUI() {
        
        detailedHistoryItemText.translatesAutoresizingMaskIntoConstraints = false
        historyItemTimeStampLabel.translatesAutoresizingMaskIntoConstraints = false
        historyEditingStyleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(detailedHistoryItemText)
        self.addSubview(historyItemTimeStampLabel)
        self.addSubview(historyEditingStyleLabel)
        
        let padding = 10.0
        
        NSLayoutConstraint.activate([
            
            detailedHistoryItemText.topAnchor.constraint(equalTo: self.topAnchor, constant: padding),
            detailedHistoryItemText.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            detailedHistoryItemText.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            
            historyItemTimeStampLabel.topAnchor.constraint(equalTo: detailedHistoryItemText.bottomAnchor, constant: padding),
            historyItemTimeStampLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            historyItemTimeStampLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -padding),
            
            historyEditingStyleLabel.topAnchor.constraint(equalTo: detailedHistoryItemText.bottomAnchor, constant: padding),
            historyEditingStyleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: padding),
            historyEditingStyleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -padding)
        ])
    }
    
    func setupCell(historyItem: EditHistoryItemResults) {
        
        roundCellCorner()
        detailedHistoryItemText.text = historyItem.result
        historyItemTimeStampLabel.text = "\(historyItem.timeStamp)"
        historyEditingStyleLabel.text = historyItem.style
    }
    
    private func roundCellCorner() {
        
        self.layer.cornerRadius = 20
        self.layer.masksToBounds = true
    }
}
