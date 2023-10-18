//
//  SettingsViewController.swift
//  Wordy Word (UIKit)
//
//  Created by Michael Caesario on 27/08/23.
//

import UIKit

protocol SettingsViewControllerDelegate: AnyObject {
    
    func updatingCurrentHistoryDataLimitValue(value: Int)
}

final class SettingsViewController: UIViewController {
    
    private let settingsNavigationBar = SubviewNavigationTitle()
    private let settingsTableView = UITableView(frame: .zero, style: .grouped)
    
    private let developerURL = "https://google.com"

    private var savedHistoryValue: Int
    
    weak var delegate: SettingsViewControllerDelegate?
    
    init(savedHistoryValue: Int) {
        self.savedHistoryValue = savedHistoryValue
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
    
    override func viewWillDisappear(_ animated: Bool) {
        
        delegate?.updatingCurrentHistoryDataLimitValue(value: savedHistoryValue)
    }
    
    // navigate to WebView
    private func presentWebView(withURL: String) {
        
        guard let url = URL(string: withURL) else { return }
        
        let webViewController = WebViewController(url: url)
        
        self.navigationController?.pushViewController(webViewController, animated: true)
    }
    
    // set the presentation sheet detent to Large
    private func setSheetDetentsToLarge() {
        
        guard let sheet = navigationController?.sheetPresentationController else { return }
        
        sheet.animateChanges {
            sheet.selectedDetentIdentifier = .large
        }
    }
}

extension SettingsViewController {
    
    private func prepareView() {
        
        view.backgroundColor = .background.primary
        navigationController?.isNavigationBarHidden = true
    }
    
    private func configureView() {
        
        settingsNavigationBar.setNavigationTitle(title: "Settings")
        
        settingsTableView.backgroundColor = .clear
        settingsTableView.dataSource = self
        settingsTableView.delegate = self
        settingsTableView.register(SavedHistorySettingsCell.self, forCellReuseIdentifier: SavedHistorySettingsCell.reuseIdentifier)
        settingsTableView.register(GoToDeveloperWebsiteCell.self, forCellReuseIdentifier: GoToDeveloperWebsiteCell.reuseIdentifier)
        settingsTableView.showsVerticalScrollIndicator = false
        settingsTableView.contentInset.top = 50
        settingsTableView.contentOffset.y = -50
    }
    
    private func layoutUI() {
        
        settingsNavigationBar.translatesAutoresizingMaskIntoConstraints = false
        settingsTableView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(settingsNavigationBar)
        view.addSubview(settingsTableView)
        settingsNavigationBar.layer.zPosition = 1
        
        NSLayoutConstraint.activate([
            
            settingsNavigationBar.topAnchor.constraint(equalTo: view.topAnchor),
            settingsNavigationBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            settingsNavigationBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            settingsNavigationBar.heightAnchor.constraint(equalToConstant: 100),
            
            settingsTableView.topAnchor.constraint(equalTo: view.topAnchor),
            settingsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            settingsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            settingsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

// MARK: - UITableView Delegate & Data Source

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
            
        case 0:
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SavedHistorySettingsCell.reuseIdentifier) as? SavedHistorySettingsCell else {
                fatalError()
            }
            
            cell.delegate = self
            cell.setupCell(currentValue: savedHistoryValue)
            cell.selectionStyle = .none
            cell.contentView.isUserInteractionEnabled = true
            
            return cell
        case 1:
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: GoToDeveloperWebsiteCell.reuseIdentifier) as? GoToDeveloperWebsiteCell else {
                fatalError()
            }
            
            cell.selectionStyle = .none
            
            return cell
        default:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "defaultCell")
            return cell ?? UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.row {
        case 1:
            
            setSheetDetentsToLarge()
            presentWebView(withURL: developerURL)
            tableView.deselectRow(at: indexPath, animated: true)
        default:
            
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath.row {
        case 0:
            return 220
        case 1:
            return 80
        default:
            return 100
        }
    }
}

// MARK: - Delegates

extension SettingsViewController: SavedHistorySettingsCellDelegate {
    
    func didFinishedChangingValue(value: Int) {
        
        savedHistoryValue = value
    }
}
