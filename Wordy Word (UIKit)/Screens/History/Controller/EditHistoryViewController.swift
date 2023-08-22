//
//  HistoryDetailsViewController.swift
//  Wordy Word (UIKit)
//
//  Created by Michael Caesario on 24/07/23.
//

import UIKit

class EditHistoryViewController: UIViewController {

    private let scrollView = UIScrollView()
    private let originalEditLabel = UILabel()
    private let originalEditText = UITextView()
    private let allEditLabel = UILabel()
    private let allEditResultTableView = UITableView()
    
    private let historyData: EditHistoryItem
    
    private let allEditResultCellIdentifier = "allEditResultHistoryCell"
    
    init(historyData: EditHistoryItem) {
        
        self.historyData = historyData
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        prepareView()
        prepareUITableView()
        layoutUI()
    }

    private func didTappedHistoryEditsItemsCell(historyItem: EditHistoryItemResults) {
        
        let detailedHistoryVC = DetailedHistoryViewController(detailedHistoryItem: historyItem)
        
        self.navigationController?.pushViewController(detailedHistoryVC, animated: true)
    }
}

extension EditHistoryViewController {
    
    private func prepareView() {
        
        view.backgroundColor = .background.thirtiary
        
        originalEditLabel.text = "Original"
        originalEditLabel.textColor = .text.white
        originalEditLabel.textAlignment = .left
        originalEditLabel.font = UIFont(name: .fonts.poppinsMedium, size: 20)
        
        originalEditText.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        originalEditText.textColor = .text.white
        originalEditText.backgroundColor = .background.secondary
        originalEditText.isScrollEnabled = false
        originalEditText.textContainerInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        originalEditText.backgroundColor = .background.thirtiary
        originalEditText.layer.cornerRadius = 20
        originalEditText.layer.masksToBounds = true
        
        allEditLabel.text = "All Edits"
        allEditLabel.textColor = .text.white
        allEditLabel.textAlignment = .left
        allEditLabel.font = UIFont(name: .fonts.poppinsMedium, size: 20)
    }
    
    private func prepareUITableView() {
        
        let padding = 16.0
        
        allEditResultTableView.dataSource = self
        allEditResultTableView.delegate = self
        allEditResultTableView.register(DetailedHistoryTableViewCell.self, forCellReuseIdentifier: allEditResultCellIdentifier)
        
        allEditResultTableView.contentInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        
    }
    
    private func layoutUI() {
        
        originalEditLabel.translatesAutoresizingMaskIntoConstraints = false
        originalEditText.translatesAutoresizingMaskIntoConstraints = false
        allEditLabel.translatesAutoresizingMaskIntoConstraints = false
        allEditResultTableView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(originalEditText)
        view.addSubview(allEditResultTableView)
        
        let padding = 16.0
        let spacer = 32.0
        
        NSLayoutConstraint.activate([
        
            originalEditLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            originalEditLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            
            originalEditText.topAnchor.constraint(equalTo: originalEditLabel.bottomAnchor, constant: padding),
            originalEditText.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            originalEditText.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            
            allEditLabel.topAnchor.constraint(equalTo: originalEditText.bottomAnchor, constant: spacer),
            allEditLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            
            allEditResultTableView.topAnchor.constraint(equalTo: allEditLabel.topAnchor, constant: padding),
            allEditResultTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            allEditResultTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding),
            allEditResultTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding)
        ])
    }
}

extension EditHistoryViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return historyData.result.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = allEditResultTableView.dequeueReusableCell(withIdentifier: allEditResultCellIdentifier, for: indexPath) as! DetailedHistoryTableViewCell
        
        let item = historyData.result[indexPath.row]
        cell.setupCell(historyItem: item)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let item = historyData.result[indexPath.row]

        didTappedHistoryEditsItemsCell(historyItem: item)
    }
}
