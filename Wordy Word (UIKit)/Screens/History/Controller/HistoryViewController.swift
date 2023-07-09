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
    
    private func prepareView() {
        
        view.backgroundColor = .background.primary
    }
    
    private func layoutUI() {
        
        historyLabel.translatesAutoresizingMaskIntoConstraints = true
        tableView.translatesAutoresizingMaskIntoConstraints = true
        
        view.addSubview(historyLabel)
        view.addSubview(tableView)
        
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
    }
}

extension HistoryViewController {
    
    
}

extension HistoryViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return historyItems.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: tableViewCellReuseIdentifier, for: indexPath)
        return cell
    }
    
    
}
