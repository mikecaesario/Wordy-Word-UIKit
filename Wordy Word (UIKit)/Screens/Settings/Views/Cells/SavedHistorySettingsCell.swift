//
//  SavedHistorySettingsCell.swift
//  Wordy Word (UIKit)
//
//  Created by Michael Caesario on 21/09/23.
//

import Foundation
import UIKit

protocol SavedHistorySettingsCellDelegate: AnyObject {
    func didFinishedChangingValue(value: Int)
}

class SavedHistorySettingsCell: UITableViewCell {
    
    private let backgroundContainer = UIView()
    private let savedHistoryLabel = UILabel()
    private let valueLabel = UILabel()
    private let valueSlider = HistoryValueUISlider()
    private let moreInfoTextView = UITextView()
    
    private let moreInfoText = "Adjust the maximum limit of historical data to be stored."
    
    weak var delegate: SavedHistorySettingsCellDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureCell()
        layoutUI()
        print("SAVED HISTORY CELL CONFIGURED")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureCell() {
        
        self.backgroundColor = .clear
        
        backgroundContainer.backgroundColor = .background.thirtiary
        backgroundContainer.layer.cornerRadius = (self.frame.height / 1.5)
        backgroundContainer.clipsToBounds = true
        
        savedHistoryLabel.text = "Saved History"
        savedHistoryLabel.textColor = .text.white
        savedHistoryLabel.font = UIFont(name: .fonts.poppinsMedium, size: 20)
        savedHistoryLabel.minimumScaleFactor = 0.8
        savedHistoryLabel.textAlignment = .left
        savedHistoryLabel.numberOfLines = 1
        
        valueLabel.textColor = .text.white
        valueLabel.font = UIFont(name: .fonts.poppinsSemiBold, size: 20)
        valueLabel.minimumScaleFactor = 0.8
        valueLabel.textAlignment = .right
        valueLabel.numberOfLines = 1
        
        valueSlider.isUserInteractionEnabled = true
        valueSlider.setupSlider(minValue: 5, maxValue: 25)
        valueSlider.addTarget(self, action: #selector(onSliderValueChanged(sender:)), for: .valueChanged)
        
        moreInfoTextView.text = moreInfoText
        moreInfoTextView.backgroundColor = .clear
        moreInfoTextView.textColor = .text.grey
        moreInfoTextView.font = UIFont(name: .fonts.poppinsMedium, size: 15)
        moreInfoTextView.textAlignment = .left
        moreInfoTextView.isEditable = false
        moreInfoTextView.isSelectable = false
        moreInfoTextView.isScrollEnabled = false
    }
    
    private func layoutUI() {
        
        backgroundContainer.translatesAutoresizingMaskIntoConstraints = false
        savedHistoryLabel.translatesAutoresizingMaskIntoConstraints = false
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        valueSlider.translatesAutoresizingMaskIntoConstraints = false
        moreInfoTextView.translatesAutoresizingMaskIntoConstraints = false
        
        let views = [backgroundContainer, savedHistoryLabel, valueLabel, valueSlider, moreInfoTextView]
        
        contentView.addSubviews(views)
        backgroundContainer.layer.zPosition = -1
        
        let padding = 16.0
        let verticalPadding = 10.0
        
        NSLayoutConstraint.activate([
            
            backgroundContainer.topAnchor.constraint(equalTo: contentView.topAnchor, constant: verticalPadding),
            backgroundContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            backgroundContainer.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -verticalPadding),
            backgroundContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
        
            savedHistoryLabel.topAnchor.constraint(equalTo: backgroundContainer.topAnchor, constant: padding),
            savedHistoryLabel.leadingAnchor.constraint(equalTo: backgroundContainer.leadingAnchor, constant: padding),
            
            valueLabel.topAnchor.constraint(equalTo: backgroundContainer.topAnchor, constant: padding),
            valueLabel.trailingAnchor.constraint(equalTo: backgroundContainer.trailingAnchor, constant: -padding),
            
            valueSlider.topAnchor.constraint(equalTo: savedHistoryLabel.bottomAnchor, constant: padding),
            valueSlider.leadingAnchor.constraint(equalTo: backgroundContainer.leadingAnchor, constant: padding),
            valueSlider.trailingAnchor.constraint(equalTo: backgroundContainer.trailingAnchor, constant: -padding),
            
            moreInfoTextView.topAnchor.constraint(equalTo: valueSlider.bottomAnchor, constant: padding),
            moreInfoTextView.leadingAnchor.constraint(equalTo: backgroundContainer.leadingAnchor, constant: padding),
            moreInfoTextView.bottomAnchor.constraint(equalTo: backgroundContainer.bottomAnchor, constant: -padding),
            moreInfoTextView.trailingAnchor.constraint(equalTo: backgroundContainer.trailingAnchor, constant: -padding),
        ])
    }
    
    @objc private func onSliderValueChanged(sender: UISlider) {
        
        let value = Int(sender.value)
        delegate?.didFinishedChangingValue(value: value)
        valueLabel.text = "\(value)"
    }
    
    func setupCell(currentValue: Int) {
        
        valueLabel.text = "\(currentValue)"
        valueSlider.value = Float(currentValue)
    }
}

