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
    
    private var detailedHistoryItem: EditHistoryItemResults? {
        didSet {
            setupDetailedFooter(item: detailedHistoryItem)
        }
    }
    
    private var originalText: String? {
        didSet {
            setupOriginalFooter(text: originalText)
        }
    }
    
    init(detailedHistoryItem: EditHistoryItemResults? = nil, originalText: String? = nil) {
        
        defer {
            self.originalText = originalText
            self.detailedHistoryItem = detailedHistoryItem
        }
        
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
        
        let padding = 16.0

        view.backgroundColor = .background.primary
        navigationController?.isNavigationBarHidden = true
        
        detailedNavigationBar.delegate = self
        
        detailedHistoryItemText.backgroundColor = .clear
        detailedHistoryItemText.font = UIFont(name: .fonts.poppinsMedium, size: 22)
        detailedHistoryItemText.contentInset = UIEdgeInsets(top: 100, left: padding, bottom: padding, right: padding)
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
    
    private func setupDetailedFooter(item: EditHistoryItemResults?) {
        
        guard let item = item else { return }
        
        detailedHistoryItemText.text = item.result
        
        let footer = DetailedHistoryNavigationFooter()
        
        footer.setupLabel(time: item.timeStamp, style: item.style)
        
        footer.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(footer)
        
        NSLayoutConstraint.activate([
            
            footer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            footer.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            footer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            footer.heightAnchor.constraint(equalToConstant: 75)
        ])
        
        print("RESULT FOOTER ADDED")

    }
    
    private func setupOriginalFooter(text: String?) {
        
        guard let text = text else { return }
        
        detailedHistoryItemText.text = text
        
        let footer = OriginalTextNavigationFooter()
        
        footer.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(footer)
        
        NSLayoutConstraint.activate([
            
            footer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            footer.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            footer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            footer.heightAnchor.constraint(equalToConstant: 75)
        ])
        
        print("ORIGINAL FOOTER ADDED")
    }
}

extension DetailedHistoryViewController: DetailedHistoryNavigationBarButtonsProtocol {
    
    func didTappedCopyToClipboardButton() {
        print("DID TAPPED COPY TO CLIPBOARD BUTTON")
    }
}
