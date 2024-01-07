//
//  HistoryViewController.swift
//  Wordy Word (UIKit)
//
//  Created by Michael Caesario on 09/07/23.
//

import UIKit

final class HistoryViewController: UIViewController {
    
    private let historyNavigationBar = SubviewNavigationTitle()
    private lazy var noHistoryLabel = UILabel()
    private lazy var tableView = UITableView(frame: .zero, style: .grouped)
    
    private let historyItems: [HistoryItems]
    
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
        configureView()
        layoutUI()
    }
    
    private func pushEditHistoryDetailView(historyItem: EditHistoryItem) {
        
        let EditHistoryVC = EditHistoryViewController(historyData: historyItem)
                
        self.navigationController?.pushViewController(EditHistoryVC, animated: true)
    }
    
    private func setSheetHeightToLarge() {
        
        if let sheet = navigationController?.sheetPresentationController {
            
            sheet.animateChanges {
                sheet.selectedDetentIdentifier = .large
            }
        }
    }
}

extension HistoryViewController {
    
    private func prepareView() {
        
        view.backgroundColor = .background.primary
        navigationController?.isNavigationBarHidden = true
    }
    
    private func configureView() {
        
        historyNavigationBar.setNavigationTitle(title: "History")
    }
    
    private func layoutUI() {
        
        historyNavigationBar.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(historyNavigationBar)
        
        historyNavigationBar.layer.zPosition = 1
                
        NSLayoutConstraint.activate([
            
            historyNavigationBar.topAnchor.constraint(equalTo: view.topAnchor),
            historyNavigationBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            historyNavigationBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            historyNavigationBar.heightAnchor.constraint(equalToConstant: 100),
        ])
        
        if historyItems.isEmpty {
            
            prepareNoHistoryLabel()
            layoutNoHistoryLabel()
        } else {
            
            prepareTableView()
            layoutTableView()
        }
    }
    
    private func prepareTableView() {
                
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.separatorColor = .clear
        tableView.showsVerticalScrollIndicator = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 400
        tableView.contentInset.top = 100
        tableView.contentOffset.y = -100
        tableView.register(HistoryTableViewCell.self, forCellReuseIdentifier: HistoryTableViewCell.reuseIdentifier)
        tableView.register(HistoryHeader.self, forHeaderFooterViewReuseIdentifier: HistoryHeader.reuseIdentifier)
    }
    
    private func prepareNoHistoryLabel() {
        
        noHistoryLabel.text = "No History"
        noHistoryLabel.textColor = .text.grey
        noHistoryLabel.font = UIFont(name: .fonts.poppinsMedium, size: 20)
    }
    
    private func layoutTableView() {
        
        tableView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(tableView)
        tableView.layer.zPosition = 0
                
        NSLayoutConstraint.activate([
            
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
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
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: HistoryHeader.reuseIdentifier) as! HistoryHeader
        
        header.setHeaderLabel(text: DateFormatter.formattedDateInFull.string(from: historyItems[section].date))
        
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: HistoryTableViewCell.reuseIdentifier, for: indexPath) as! HistoryTableViewCell
        
        let historyItem = historyItems[indexPath.section].items[indexPath.row]
        
        cell.setupCell(histroyItem: historyItem)
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let historyItem = historyItems[indexPath.section].items[indexPath.row]
                
        setSheetHeightToLarge()
        pushEditHistoryDetailView(historyItem: historyItem)
    }
}
