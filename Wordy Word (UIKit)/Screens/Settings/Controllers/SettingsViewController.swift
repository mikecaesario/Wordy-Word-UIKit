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
        navigationController?.isNavigationBarHidden = true
    }
    
    private func configureView() {
        
        settingsNavigationBar.setNavigationTitle(title: "Settings")
        
        settingsTableView.backgroundColor = .clear
        settingsTableView.dataSource = self
        settingsTableView.delegate = self
        settingsTableView.register(SavedHistorySettingsCell.self, forCellReuseIdentifier: savedHistoryReusableCellIdentifier)
        settingsTableView.register(GoToDeveloperWebsiteCell.self, forCellReuseIdentifier: goToDeveloperWebsiteCellIdentifier)
//        settingsTableView.estimatedRowHeight = 200
//        settingsTableView.rowHeight = UITableView.automaticDimension
        settingsTableView.showsVerticalScrollIndicator = false
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
            cell.selectionStyle = .none
            cell.contentView.isUserInteractionEnabled = true
            return cell
        case 1:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: goToDeveloperWebsiteCellIdentifier) as! GoToDeveloperWebsiteCell
            cell.selectionStyle = .none
            return cell
        default:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "defaultCell")
            return cell ?? UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.row {
            
        case 0:
            print("cell selected")
        case 1:
            
            tableView.deselectRow(at: indexPath, animated: true)
        default:
            break
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
    private let valueSlider = HistoryValueUISlider()
    private let moreInfoTextView = UITextView()
    
    private let moreInfoText = "Adjust the maximum limit of historical data to be stored."
    
    weak var delegate: SavedHistorySettingsCellDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureCell()
        layoutUI()
        print("SAVED HISTORY CELL CONFIGURED")
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
        
//        valueSlider.backgroundColor = .blue
//        valueSlider.isEnabled = true
        valueSlider.isUserInteractionEnabled = true
        valueSlider.setupSlider(minValue: 5, maxValue: 25)
        valueSlider.addTarget(self, action: #selector(onSliderValueChanged(sender:)), for: .valueChanged)
        
        moreInfoTextView.text = moreInfoText
        moreInfoTextView.backgroundColor = .clear
        moreInfoTextView.textColor = .text.grey
        moreInfoTextView.font = UIFont(name: .fonts.poppinsMedium, size: 15)
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
        
        contentView.addSubviews(views)
        backgroundContainer.layer.zPosition = -1
        
        let padding = 16.0
        let verticalPadding = 10.0
        
        NSLayoutConstraint.activate([
            
            backgroundContainer.topAnchor.constraint(equalTo: contentView.topAnchor, constant: verticalPadding),
            backgroundContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            backgroundContainer.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -verticalPadding),
            backgroundContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
        
            savedHistoryLabel.topAnchor.constraint(equalTo: backgroundContainer.topAnchor, constant: padding),
            savedHistoryLabel.leadingAnchor.constraint(equalTo: backgroundContainer.leadingAnchor, constant: padding),
            
            valueLabel.topAnchor.constraint(equalTo: backgroundContainer.topAnchor, constant: padding),
            valueLabel.trailingAnchor.constraint(equalTo: backgroundContainer.trailingAnchor, constant: -padding),
            
            valueSlider.topAnchor.constraint(equalTo: savedHistoryLabel.bottomAnchor, constant: padding),
            valueSlider.leadingAnchor.constraint(equalTo: backgroundContainer.leadingAnchor, constant: padding),
            valueSlider.trailingAnchor.constraint(equalTo: backgroundContainer.trailingAnchor, constant: -padding),
            
            moreInfoTextView.topAnchor.constraint(equalTo: valueSlider.bottomAnchor, constant: padding),
            moreInfoTextView.leadingAnchor.constraint(equalTo: backgroundContainer.leadingAnchor, constant: padding),
            moreInfoTextView.bottomAnchor.constraint(equalTo: backgroundContainer.bottomAnchor, constant: -padding),
            moreInfoTextView.trailingAnchor.constraint(equalTo: backgroundContainer.trailingAnchor, constant: -padding),
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

// MARK: - CUSTOM SLIDER

class HistoryValueUISlider: UISlider {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureSlider()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func trackRect(forBounds bounds: CGRect) -> CGRect {
        var customTrackSize = super.trackRect(forBounds: bounds)
        customTrackSize.size.height = 12
        return customTrackSize
    }
    
    private func configureSlider() {
        minimumTrackTintColor = .background.quarternary
        thumbTintColor = .background.quarternary
        maximumTrackTintColor = .background.secondary
        isContinuous = true
    }
    
    func setupSlider(minValue: Float, maxValue: Float) {
        minimumValue = minValue
        maximumValue = maxValue
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
        
        configureCell()
        layoutUI()
        print("DEV CELL CONFIGURED")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureCell() {
        
        self.backgroundColor = .clear
        
        backgroundContainer.backgroundColor = .background.thirtiary
        backgroundContainer.layer.cornerRadius = (self.frame.height / 2.0)
        backgroundContainer.clipsToBounds = true
        
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
        backgroundContainer.layer.zPosition = -1
        
        let padding = 16.0
        let verticalPadding = 10.0
        
        NSLayoutConstraint.activate([
        
            backgroundContainer.topAnchor.constraint(equalTo: self.topAnchor, constant: verticalPadding),
            backgroundContainer.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            backgroundContainer.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -verticalPadding),
            backgroundContainer.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            backgroundContainer.heightAnchor.constraint(equalToConstant: 70),
            
            developerLabel.leadingAnchor.constraint(equalTo: backgroundContainer.leadingAnchor, constant: padding),
            developerLabel.centerYAnchor.constraint(equalTo: backgroundContainer.centerYAnchor),
            
            developerNameLabel.trailingAnchor.constraint(equalTo: backgroundContainer.trailingAnchor, constant: -padding),
            developerNameLabel.centerYAnchor.constraint(equalTo: backgroundContainer.centerYAnchor),
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
