//
//  DetailedHistoryViewController.swift
//  Wordy Word (UIKit)
//
//  Created by Michael Caesario on 28/07/23.
//

import UIKit

class DetailedHistoryViewController: UIViewController {

    private let detailedNavigationBar = DetailedHistoryNavigationBarButtons()
    private let detailedHistoryItemText = UITextView()
    
    private let detailedHistoryItem: EditHistoryItemResults
    
    init(detailedHistoryItem: EditHistoryItemResults) {
        
        self.detailedHistoryItem = detailedHistoryItem
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
        layoutUI()
    }
}

extension DetailedHistoryViewController {
    
    private func configureView() {
        
        view.backgroundColor = .background.primary
        navigationController?.isNavigationBarHidden = true
        
        detailedNavigationBar.delegate = self
        
        configureDetailedTextView()
    }
    
    private func configureDetailedTextView() {
        
        let padding = 16.0
        
        detailedHistoryItemText.font = UIFont(name: .fonts.poppinsMedium, size: 22)
        detailedHistoryItemText.text = detailedHistoryItem.result
        detailedHistoryItemText.contentInset = UIEdgeInsets(top: 110, left: padding, bottom: padding, right: padding)
        detailedHistoryItemText.isEditable = false
        detailedHistoryItemText.isSelectable = true
        detailedHistoryItemText.textColor = .text.white
        detailedHistoryItemText.textAlignment = .left
    }
    
    private func layoutUI() {
        
        detailedNavigationBar.translatesAutoresizingMaskIntoConstraints = false
        detailedHistoryItemText.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(detailedNavigationBar)
        view.addSubview(detailedHistoryItemText)
        
        detailedHistoryItemText.layer.zPosition = -1
        view.bringSubviewToFront(detailedNavigationBar)
                
        NSLayoutConstraint.activate([
        
            detailedNavigationBar.topAnchor.constraint(equalTo: view.topAnchor),
            detailedNavigationBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            detailedNavigationBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            detailedNavigationBar.heightAnchor.constraint(equalToConstant: 100),

            detailedHistoryItemText.topAnchor.constraint(equalTo: view.topAnchor),
            detailedHistoryItemText.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            detailedHistoryItemText.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            detailedHistoryItemText.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

extension DetailedHistoryViewController: DetailedHistoryNavigationBarButtonsProtocol {
    
    func didTappedCopyToClipboardButton() {
        print("DID TAPPED COPY TO CLIPBOARD BUTTON")
    }
}
