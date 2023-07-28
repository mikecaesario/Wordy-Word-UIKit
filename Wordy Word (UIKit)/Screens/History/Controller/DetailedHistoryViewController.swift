//
//  DetailedHistoryViewController.swift
//  Wordy Word (UIKit)
//
//  Created by Michael Caesario on 28/07/23.
//

import UIKit

class DetailedHistoryViewController: UIViewController {

    private let detailedHistoryItemText = UITextView()
    private let copyItemButton = UIButton()
    
    private let detailedHistoryItem: String
    private let padding = 16.0
    
    init(detailedHistoryItem: String) {
        
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

}

extension DetailedHistoryViewController {
    
    private func prepareView() {
        
        view.backgroundColor = .background.primary
        
        detailedHistoryItemText.text = detailedHistoryItem
        detailedHistoryItemText.contentInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
    }
    
    private func layoutUI() {
        
        detailedHistoryItemText.translatesAutoresizingMaskIntoConstraints = false
        copyItemButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(detailedHistoryItemText)
        view.addSubview(copyItemButton)
        
        let padding = 16.0
        
        NSLayoutConstraint.activate([
        
            detailedHistoryItemText.topAnchor.constraint(equalTo: view.topAnchor),
            detailedHistoryItemText.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            detailedHistoryItemText.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            detailedHistoryItemText.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}
