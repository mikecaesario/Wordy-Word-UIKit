//
//  HistoryHeader.swift
//  Wordy Word (UIKit)
//
//  Created by Michael Caesario on 12/08/23.
//

import UIKit

class HistoryHeader: UITableViewHeaderFooterView {

    let dateLabelHeader = UILabel()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        layoutUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func prepareHeader() {
        
        self.backgroundColor = .clear
        
        dateLabelHeader.font = UIFont(name: .fonts.poppinsSemiBold, size: 17)
        dateLabelHeader.textColor = .text.white
        dateLabelHeader.numberOfLines = 1
        dateLabelHeader.minimumScaleFactor = 0.7
        dateLabelHeader.textAlignment = .left
    }
    
    private func layoutUI() {
        
        dateLabelHeader.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(dateLabelHeader)
        
        NSLayoutConstraint.activate([
            
            dateLabelHeader.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            dateLabelHeader.heightAnchor.constraint(equalToConstant: 20),
            dateLabelHeader.widthAnchor.constraint(equalTo: self.widthAnchor)
        ])
    }
    
    func setHeaderLabel(text: String) {
        
        dateLabelHeader.text = text
    }

}
