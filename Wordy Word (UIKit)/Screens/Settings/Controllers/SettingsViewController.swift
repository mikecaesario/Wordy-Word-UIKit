//
//  SettingsViewController.swift
//  Wordy Word (UIKit)
//
//  Created by Michael Caesario on 27/08/23.
//

import UIKit

class SettingsViewController: UIViewController {
    
    private let settingsNavigationBar = SubviewNavigationTitle()
    private let settingsTableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()

        prepareView()
        configureView()
        layoutUI()
    }
    
    private func prepareView() {
        
        view.backgroundColor = .background.primary
    }
    
    private func configureView() {
        
        settingsNavigationBar.setNavigationTitle(title: "Settings")
    }
    
    private func layoutUI() {
        
        settingsNavigationBar.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(settingsNavigationBar)
        settingsNavigationBar.layer.zPosition = 1
        
        NSLayoutConstraint.activate([
            
            settingsNavigationBar.topAnchor.constraint(equalTo: view.topAnchor),
            settingsNavigationBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            settingsNavigationBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            settingsNavigationBar.heightAnchor.constraint(equalToConstant: 60)
        ])
        
    }
}


