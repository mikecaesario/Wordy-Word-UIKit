//
//  SettingsViewController.swift
//  Wordy Word (UIKit)
//
//  Created by Michael Caesario on 27/08/23.
//

import UIKit

final class SettingsViewController: UIViewController {
    private let settingsNavigationBar = SubviewNavigationTitle()
    private let settingsTableView = UITableView(frame: .zero, style: .grouped)
    
    private let savedHistoryReusableCellIdentifier = "savedHistoryReusableCellIdentifier"
    private let goToDeveloperWebsiteCellIdentifier = "goToDeveloperWebsiteCellIdentifier"

    private let savedHistoryValue: Int
    
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
    
    private func presentWebView(withURL: String) {
        
        guard let url = URL(string: withURL), let sheet = navigationController?.sheetPresentationController else { return }
        
        sheet.animateChanges {
            sheet.selectedDetentIdentifier = .large
        }
    }
}

extension SettingsViewController {
    
    private func prepareView() {
        
        view.backgroundColor = .background.primary
    }
    
    private func configureView() {
        
        settingsNavigationBar.setNavigationTitle(title: "Settings")
        
        settingsTableView.dataSource = self
        settingsTableView.delegate = self
        settingsTableView.register(SavedHistorySettingsCell.self, forCellReuseIdentifier: savedHistoryReusableCellIdentifier)
        settingsTableView.register(GoToDeveloperWebsiteCell.self, forCellReuseIdentifier: goToDeveloperWebsiteCellIdentifier)
    }
    
    private func layoutUI() {
        
        settingsNavigationBar.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(settingsNavigationBar)
        settingsNavigationBar.layer.zPosition = 1
        
        NSLayoutConstraint.activate([
            
            settingsNavigationBar.topAnchor.constraint(equalTo: view.topAnchor),
            settingsNavigationBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            settingsNavigationBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            settingsNavigationBar.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
}

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
            
        case 0:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: savedHistoryReusableCellIdentifier) as! SavedHistorySettingsCell
            cell.delegate = self
            cell.setupCell(currentValue: savedHistoryValue)
            return cell
        case 1:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: goToDeveloperWebsiteCellIdentifier) as! GoToDeveloperWebsiteCell
            return cell
        default:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "defaultCell")
            return cell ?? UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.row {
            
        case 1:
            tableView.deselectRow(at: indexPath, animated: true)
        default:
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
}

extension SettingsViewController: SavedHistorySettingsCellDelegate {
    
    func didFinishedChangingValue(value: Int) {
        print("SAVED HISTORY VALUE CHANGED TO \(value)")
    }
}

// MARK: - SAVED HISTORY SETTINGS CELL

protocol SavedHistorySettingsCellDelegate: AnyObject {
    func didFinishedChangingValue(value: Int)
}

class SavedHistorySettingsCell: UITableViewCell {
    
    private let backgroundContainer = UIView()
    private let savedHistoryLabel = UILabel()
    private let valueLabel = UILabel()
    private let valueSlider = UISlider()
    private let moreInfoTextView = UITextView()
    
    private let moreInfoText = "Adjust the maximum limit of historical data to be stored."
    
    weak var delegate: SavedHistorySettingsCellDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureCell()
        layoutUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureCell() {
        
        self.backgroundColor = .clear
        
        backgroundContainer.backgroundColor = .background.thirtiary
        backgroundContainer.layer.cornerRadius = (self.frame.height / 1.5)
        backgroundContainer.clipsToBounds = true
        
        savedHistoryLabel.text = "Saved History"
        savedHistoryLabel.textColor = .text.white
        savedHistoryLabel.font = UIFont(name: .fonts.poppinsMedium, size: 20)
        savedHistoryLabel.minimumScaleFactor = 0.8
        savedHistoryLabel.textAlignment = .left
        savedHistoryLabel.numberOfLines = 1
        
        valueLabel.textColor = .text.white
        valueLabel.font = UIFont(name: .fonts.poppinsSemiBold, size: 20)
        valueLabel.minimumScaleFactor = 0.8
        valueLabel.textAlignment = .right
        valueLabel.numberOfLines = 1
        
        valueSlider.minimumTrackTintColor = .background.quarternary
        valueSlider.thumbTintColor = .background.quarternary
        valueSlider.maximumTrackTintColor = .background.secondary
        valueSlider.minimumValue = 1
        valueSlider.maximumValue = 50
        valueSlider.isContinuous = true
        valueSlider.addTarget(self, action: #selector(onSliderValueChanged(sender:)), for: .editingDidEnd)
        
        moreInfoTextView.textColor = .text.grey
        moreInfoTextView.font = UIFont(name: .fonts.poppinsSemiBold, size: 20)
        moreInfoTextView.textAlignment = .left
        moreInfoTextView.isEditable = false
        moreInfoTextView.isSelectable = false
        moreInfoTextView.isScrollEnabled = false
    }
    
    private func layoutUI() {
        
        backgroundContainer.translatesAutoresizingMaskIntoConstraints = false
        savedHistoryLabel.translatesAutoresizingMaskIntoConstraints = false
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        valueSlider.translatesAutoresizingMaskIntoConstraints = false
        moreInfoTextView.translatesAutoresizingMaskIntoConstraints = false
        
        let views = [backgroundContainer, savedHistoryLabel, valueLabel, valueSlider, moreInfoTextView]
        
        self.addSubviews(views)
        
        let padding = 16.0
        
        NSLayoutConstraint.activate([
            
            backgroundContainer.topAnchor.constraint(equalTo: self.topAnchor),
            backgroundContainer.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            backgroundContainer.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            backgroundContainer.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        
            savedHistoryLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: padding),
            savedHistoryLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            
            valueLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: padding),
            valueLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            
            valueSlider.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            valueSlider.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            valueSlider.heightAnchor.constraint(equalToConstant: 25),
            
            moreInfoTextView.topAnchor.constraint(equalTo: valueSlider.bottomAnchor, constant: padding),
            moreInfoTextView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            moreInfoTextView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -padding),
            moreInfoTextView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
        ])
    }
    
    @objc private func onSliderValueChanged(sender: UISlider) {
        
        let value = Int(sender.value)
        delegate?.didFinishedChangingValue(value: value)
        valueLabel.text = "\(value)"
    }
    
    func setupCell(currentValue: Int) {
        
        valueLabel.text = "\(currentValue)"
        valueSlider.value = Float(currentValue)
    }
}

// MARK: - SAVED HISTORY SETTINGS CELL

class GoToDeveloperWebsiteCell: UITableViewCell {
    
    private let backgroundContainer = UIView()
    private let developerLabel = UILabel()
    private let developerNameLabel = UILabel()
    
    private let devName = "Michael Caesario"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureCell() {
        
        self.backgroundColor = .clear
        
        developerLabel.text = "Developer"
        developerLabel.textColor = .text.white
        developerLabel.textAlignment = .left
        developerLabel.numberOfLines = 1
        developerLabel.minimumScaleFactor = 0.8
        developerLabel.font = UIFont(name: .fonts.poppinsMedium, size: 20)
        
        developerNameLabel.text = devName
        developerNameLabel.textColor = .text.white
        developerNameLabel.textAlignment = .left
        developerNameLabel.numberOfLines = 1
        developerNameLabel.minimumScaleFactor = 0.8
        developerNameLabel.font = UIFont(name: .fonts.poppinsSemiBold, size: 20)
    }
    
    private func layoutUI() {
        
        backgroundContainer.translatesAutoresizingMaskIntoConstraints = false
        developerLabel.translatesAutoresizingMaskIntoConstraints = false
        developerNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let views = [backgroundContainer, developerLabel, developerNameLabel]
        
        self.addSubviews(views)
        
        let padding = 16.0
        
        NSLayoutConstraint.activate([
        
            backgroundContainer.topAnchor.constraint(equalTo: self.topAnchor),
            backgroundContainer.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            backgroundContainer.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            backgroundContainer.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            developerLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            developerLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            developerNameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            developerNameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
}

// MARK: - UIVIEW EXTENSION

extension UIView {
    
    func addSubviews(_ views: [UIView]) {
        
        for view in views {
            self.addSubview(view)
        }
    }
}
