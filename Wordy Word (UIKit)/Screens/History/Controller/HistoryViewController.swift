//
//  HistoryViewController.swift
//  Wordy Word (UIKit)
//
//  Created by Michael Caesario on 09/07/23.
//

import UIKit

class HistoryViewController: UIViewController {
    
    private let tableView = UITableView()
    private let historyLabel = UILabel()
    private let noHistoryLabel = UILabel()
    private let closeButton = UIButton()
    
    private var historyItems: [HistoryItems]
    private let tableViewCellReuseIdentifier = "HistoryCell"
    
    init(historyItems: [HistoryItems]) {
        
        self.historyItems = historyItems
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
    
    private func pushEditHistoryDetailView(historyItem: EditHistoryItem) {
        
        
    }
}

extension HistoryViewController {
    
    private func prepareView() {
        
        view.backgroundColor = .background.thirtiary
        
        historyLabel.text = "History"
        historyLabel.textColor = .text.white
        historyLabel.font = UIFont(name: "Poppins-Medium", size: 30)
        
        noHistoryLabel.text = "No History"
        noHistoryLabel.textColor = .text.grey
        noHistoryLabel.font = UIFont(name: "Poppins-Medium", size: 15)
        
        navigationController?.isNavigationBarHidden = true
    }
    
    private func prepareTableView() {
        
        tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false
        tableView.contentInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        tableView.register(HistoryTableViewCell.self, forCellReuseIdentifier: tableViewCellReuseIdentifier)
    }
    
    private func layoutUI() {
        
        historyLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(historyLabel)
        
        let padding = 18.0
        
        NSLayoutConstraint.activate([
            
            historyLabel.topAnchor.constraint(equalTo: view.topAnchor),
            historyLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            historyLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            historyLabel.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.2),
        ])
        
        if historyItems.isEmpty {
            
            layoutNoHistoryLabel()
        } else {
            
            layoutTableView()
        }
    }
    
    private func layoutTableView() {
        
        tableView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            
            tableView.topAnchor.constraint(equalTo: historyLabel.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    
    private func layoutNoHistoryLabel() {
        
        noHistoryLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(noHistoryLabel)
        
        NSLayoutConstraint.activate([
        
            noHistoryLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            noHistoryLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}

extension HistoryViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return historyItems.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return historyItems[section].items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: tableViewCellReuseIdentifier, for: indexPath) as! HistoryTableViewCell
        
        let historyItem = historyItems[indexPath.section].items[indexPath.row]
        
        cell.setupCell(histroyItem: historyItem)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let historyItem = historyItems[indexPath.section].items[indexPath.row]
        
        pushEditHistoryDetailView(historyItem: historyItem)
    }
}
