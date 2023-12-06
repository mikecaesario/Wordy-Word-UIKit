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
    
    private var detailedHistoryItem: EditHistoryItemResults?
    private var originalText: String?
    
    init(detailedHistoryItem: EditHistoryItemResults? = nil, originalText: String? = nil) {
        
        self.originalText = originalText
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
        setupDetailedFooter(item: detailedHistoryItem)
        setupOriginalFooter(text: originalText)
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
        detailedHistoryItemText.textContainerInset = UIEdgeInsets(top: 100, left: padding, bottom: 100, right: padding)
        detailedHistoryItemText.isEditable = false
        detailedHistoryItemText.isSelectable = true
        detailedHistoryItemText.textColor = .text.white
        detailedHistoryItemText.textAlignment = .left
        detailedHistoryItemText.tintColor = .white
        
    }
    
    private func layoutUI() {
        
        detailedNavigationBar.translatesAutoresizingMaskIntoConstraints = false
        detailedHistoryItemText.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubviews([detailedNavigationBar, detailedHistoryItemText])
        
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
            detailedHistoryItemText.trailingAnchor.constraint(equalTo: view.trailingAnchor),
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
            footer.heightAnchor.constraint(equalToConstant: 100)
        ])
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
            footer.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
}

extension DetailedHistoryViewController: DetailedHistoryNavigationBarButtonsProtocol {
    
    func didFinishedTappingBackButton() {
        navigationController?.popViewController(animated: true)
    }
    
    func didFinishTappingCopyToClipboardButton() {
        
        let haptics = UIImpactFeedbackGenerator(style: .medium)

        if let historyText = detailedHistoryItem?.result {
            UIPasteboard.general.string = historyText
        } else if let originalText = originalText {
            UIPasteboard.general.string = originalText
        }
        
        haptics.impactOccurred(intensity: 0.7)
        detailedNavigationBar.animateCopyButtonOnSuccess()
    }
}
