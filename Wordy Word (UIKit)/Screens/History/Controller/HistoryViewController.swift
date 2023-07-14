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
    
    private var historyItems: [HistoryItems] = []
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
        
        // Do any additional setup after loading the view.
        prepareView()
    }
    
}

extension HistoryViewController {
    
    private func prepareView() {
        
        view.backgroundColor = .background.primary
        
        historyLabel.text = "History"
        historyLabel.textColor = .text.white
        historyLabel.font = UIFont(name: "Poppins-Medium", size: 28)
    }
    
    private func prepareTableView() {
        
        tableView.backgroundColor = .clear
        tableView.register(HistoryTableViewCell.self, forCellReuseIdentifier: tableViewCellReuseIdentifier)
    }
    
    private func layoutUI() {
        
        historyLabel.translatesAutoresizingMaskIntoConstraints = true
        
        view.addSubview(historyLabel)
        
        let padding = 16.0
        
        NSLayoutConstraint.activate([
            
            historyLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            historyLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            historyLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            historyLabel.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.2),
            
            tableView.topAnchor.constraint(equalTo: historyLabel.bottomAnchor, constant: padding),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
        ])
        
        if historyItems.isEmpty {
            
            layoutNoHistoryLabel()
        } else {
            
            layoutTableView()
        }
    }
    
    private func layoutTableView() {
        
        tableView.translatesAutoresizingMaskIntoConstraints = true

        view.addSubview(tableView)

        let padding = 18.0
        
        NSLayoutConstraint.activate([
            
            tableView.topAnchor.constraint(equalTo: historyLabel.bottomAnchor, constant: padding),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
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
        
        let item = historyItems[indexPath.section].items[indexPath.row]
        
        cell.setupCell(histroyItem: item)
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
}
