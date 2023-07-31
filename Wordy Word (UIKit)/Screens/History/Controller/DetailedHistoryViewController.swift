//
//  DetailedHistoryViewController.swift
//  Wordy Word (UIKit)
//
//  Created by Michael Caesario on 28/07/23.
//

import UIKit

class DetailedHistoryViewController: UIViewController {

    private let detailedHistoryItemText = UITextView()
    private let backButton = UIButton()
    private let copyItemButton = UIButton()
    
    private let detailedHistoryItem: EditHistoryItemResults
    private let padding = 16.0
    
    init(detailedHistoryItem: EditHistoryItemResults) {
        
        self.detailedHistoryItem = detailedHistoryItem
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        prepareView()
        layoutUI()
    }

    @objc private func didTappedCopyButton() {
        
    }
}

extension DetailedHistoryViewController {
    
    private func prepareView() {
        
        view.backgroundColor = .background.primary
                
        detailedHistoryItemText.font = UIFont(name: .fonts.poppinsMedium, size: 22)
        detailedHistoryItemText.text = detailedHistoryItem.result
        detailedHistoryItemText.contentInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        
        copyItemButton.addTarget(self, action: #selector(didTappedCopyButton), for: .touchUpInside)
        copyItemButton.backgroundColor = .button.copy
        copyItemButton.tintColor = .text.white
    }
    
    private func layoutUI() {
        
        copyItemButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.translatesAutoresizingMaskIntoConstraints = false
        detailedHistoryItemText.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(copyItemButton)
        view.addSubview(backButton)
        view.addSubview(detailedHistoryItemText)
        
        detailedHistoryItemText.layer.zPosition = -1
        
        let multiplier = 0.2
        
        NSLayoutConstraint.activate([
        
            backButton.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            backButton.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: multiplier),
            backButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: multiplier),
            
            backButton.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            backButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            backButton.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: multiplier),
            backButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: multiplier * 2),

            detailedHistoryItemText.topAnchor.constraint(equalTo: view.topAnchor),
            detailedHistoryItemText.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            detailedHistoryItemText.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            detailedHistoryItemText.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}
