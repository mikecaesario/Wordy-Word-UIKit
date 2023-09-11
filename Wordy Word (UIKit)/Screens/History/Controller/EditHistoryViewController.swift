//
//  HistoryDetailsViewController.swift
//  Wordy Word (UIKit)
//
//  Created by Michael Caesario on 24/07/23.
//

import UIKit

class EditHistoryViewController: UIViewController {

    private let navigationBar = EditHistoryNavigationBar()
    private let allEditResultTableView = UITableView(frame: .zero, style: .grouped)
    
    private let historyData: EditHistoryItem
    
    private let editHistoryHeaderIdentifier = "editHistoryHeaderIdentifier"
    private let originalTextCellIdentifier = "originalTextCellIdentifier"
    private let editedItemCellIdentifier = "editedItemCellIdentifier"
    
    init(historyData: EditHistoryItem) {
        
        self.historyData = historyData
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
        prepareUITableView()
        layoutUI()
    }

    private func didTappedHistoryEditsItemsCell(historyItem: EditHistoryItemResults? = nil, originalText: String? = nil) {
        
        let detailedHistoryVC = DetailedHistoryViewController(detailedHistoryItem: historyItem, originalText: originalText)
        
        self.navigationController?.pushViewController(detailedHistoryVC, animated: true)
    }
}

extension EditHistoryViewController {
    
    private func configureView() {
        
        view.backgroundColor = .background.primary
        navigationController?.isNavigationBarHidden = true
        
        navigationBar.delegate = self
    }
    
    private func prepareUITableView() {
        
        allEditResultTableView.dataSource = self
        allEditResultTableView.delegate = self
        allEditResultTableView.register(HistoryHeader.self, forHeaderFooterViewReuseIdentifier: editHistoryHeaderIdentifier)
        allEditResultTableView.register(EditedItemTableViewCell.self, forCellReuseIdentifier: editedItemCellIdentifier)
        allEditResultTableView.register(OriginalHistoryTableviewCell.self, forCellReuseIdentifier: originalTextCellIdentifier)
        allEditResultTableView.estimatedRowHeight = 400
        allEditResultTableView.rowHeight = UITableView.automaticDimension
        allEditResultTableView.showsVerticalScrollIndicator = false
        allEditResultTableView.backgroundColor = .clear
        allEditResultTableView.contentInset = UIEdgeInsets(top: 100, left: 0, bottom: 0, right: 0)
        allEditResultTableView.contentOffset.y = -100
    }
    
    private func layoutUI() {
        
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        allEditResultTableView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(navigationBar)
        view.addSubview(allEditResultTableView)
        
        allEditResultTableView.layer.zPosition = -1
        view.bringSubviewToFront(navigationBar)
        
        NSLayoutConstraint.activate([
            
            navigationBar.topAnchor.constraint(equalTo: view.topAnchor),
            navigationBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navigationBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            navigationBar.heightAnchor.constraint(equalToConstant: 100),
            
            allEditResultTableView.topAnchor.constraint(equalTo: view.topAnchor),
            allEditResultTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            allEditResultTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            allEditResultTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

extension EditHistoryViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 2
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: editHistoryHeaderIdentifier) as! HistoryHeader
        
        if section == 0 {
            header.setHeaderLabel(text: "Original")
        } else {
            header.setHeaderLabel(text: "Edits")
        }
        
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return 1
        } else {
            return historyData.result.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let originalCell = tableView.dequeueReusableCell(withIdentifier: originalTextCellIdentifier) as! OriginalHistoryTableviewCell
        let editCell = tableView.dequeueReusableCell(withIdentifier: editedItemCellIdentifier, for: indexPath) as! EditedItemTableViewCell
        
        if indexPath.section == 0 {
            
            let originalItem = historyData.uneditedItem
            originalCell.setupCell(originalHistoryItem: originalItem)
            originalCell.selectionStyle = .none
            
            return originalCell
        } else {
            
            let item = historyData.result[indexPath.row]
            editCell.setupCell(historyItem: item)
            editCell.selectionStyle = .none
            
            return editCell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.section == 0 {
            
            let item = historyData.uneditedItem
            
            didTappedHistoryEditsItemsCell(originalText: item)
        } else {
            
            let item = historyData.result[indexPath.row]
            
            didTappedHistoryEditsItemsCell(historyItem: item)
        }
    }
}

extension EditHistoryViewController: EditHistoryNavigationBarDelegate {
    
    func didFinishTappingBackButton() {
        navigationController?.popViewController(animated: true)
        print("DISMISS BUTTON TAPPED")
    }
}
