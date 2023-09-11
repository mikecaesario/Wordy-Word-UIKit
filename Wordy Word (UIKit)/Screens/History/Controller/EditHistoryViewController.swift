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
        allEditResultTableView.contentInset = UIEdgeInsets(top: 110, left: 0, bottom: 0, right: 0)
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

extension EditHistoryViewController: EditHistoryNavigationBarDelegate {
    
    func didFinishTappingBackButton() {
        navigationController?.popViewController(animated: true)
        print("DISMISS BUTTON TAPPED")
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
        return 50
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

class EditedItemTableViewCell: UITableViewCell {
    
    private let backgroundContainer = UIView()
    private let editedItemText = UITextView()
    private let timeStampLabel = UILabel()
    private let editingStyleLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureView()
        layoutUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView() {
                
        self.backgroundColor = .clear
        
        backgroundContainer.backgroundColor = .background.thirtiary
        backgroundContainer.layer.cornerRadius = (self.frame.height / 1.5)
        backgroundContainer.layer.masksToBounds = true
        
        editedItemText.backgroundColor = .clear
        editedItemText.font = UIFont(name: .fonts.poppinsMedium, size: 16)
        editedItemText.textColor = .text.white
        editedItemText.textContainer.maximumNumberOfLines = 5
        editedItemText.textContainer.lineBreakMode = .byTruncatingTail
        editedItemText.isEditable = false
        editedItemText.isSelectable = false
        editedItemText.isScrollEnabled = false
        
        timeStampLabel.font = UIFont(name: .fonts.poppinsMedium, size: 12)
        timeStampLabel.textColor = .text.grey
        timeStampLabel.textAlignment = .left
        timeStampLabel.numberOfLines = 1
        
        editingStyleLabel.font = UIFont(name: .fonts.poppinsMedium, size: 12)
        editingStyleLabel.textColor = .text.grey
        editingStyleLabel.textAlignment = .right
        editingStyleLabel.numberOfLines = 1
    }
    
    private func layoutUI() {
        
        backgroundContainer.translatesAutoresizingMaskIntoConstraints = false
        editedItemText.translatesAutoresizingMaskIntoConstraints = false
        timeStampLabel.translatesAutoresizingMaskIntoConstraints = false
        editingStyleLabel.translatesAutoresizingMaskIntoConstraints = false

        self.addSubview(editedItemText)
        self.addSubview(timeStampLabel)
        self.addSubview(editingStyleLabel)
        self.addSubview(backgroundContainer)
        
        backgroundContainer.layer.zPosition = -1

        let verticalPadding = 10.0
        let padding = 16.0
        
        NSLayoutConstraint.activate([
            
            backgroundContainer.topAnchor.constraint(equalTo: self.topAnchor, constant: verticalPadding),
            backgroundContainer.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            backgroundContainer.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -verticalPadding),
            backgroundContainer.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            
            editedItemText.topAnchor.constraint(equalTo: backgroundContainer.topAnchor, constant: padding),
            editedItemText.leadingAnchor.constraint(equalTo: backgroundContainer.leadingAnchor, constant: padding),
            editedItemText.trailingAnchor.constraint(equalTo: backgroundContainer.trailingAnchor, constant: -padding),
            
            timeStampLabel.topAnchor.constraint(equalTo: editedItemText.bottomAnchor, constant: 5),
            timeStampLabel.leadingAnchor.constraint(equalTo: backgroundContainer.leadingAnchor, constant: padding),
            timeStampLabel.bottomAnchor.constraint(equalTo: backgroundContainer.bottomAnchor, constant: -padding),
            timeStampLabel.heightAnchor.constraint(equalToConstant: 10),
            
            editingStyleLabel.topAnchor.constraint(equalTo: editedItemText.bottomAnchor, constant: 5),
            editingStyleLabel.trailingAnchor.constraint(equalTo: backgroundContainer.trailingAnchor, constant: -padding),
            editingStyleLabel.bottomAnchor.constraint(equalTo: backgroundContainer.bottomAnchor, constant: -padding),
            editingStyleLabel.heightAnchor.constraint(equalToConstant: 10)
        ])
    }
    
    func setupCell(historyItem: EditHistoryItemResults) {
        
        editedItemText.text = historyItem.result
        timeStampLabel.text = DateFormatter.formattedHourFromDate.string(from: historyItem.timeStamp)
        editingStyleLabel.text = historyItem.style
    }
}

class OriginalHistoryTableviewCell: UITableViewCell {
    
    private let originalHistoryText = UITextView()
    
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
        
        originalHistoryText.backgroundColor = .clear
        originalHistoryText.textColor = .text.white
        originalHistoryText.font = UIFont(name: .fonts.poppinsMedium, size: 22)
        originalHistoryText.textAlignment = .left
        originalHistoryText.textContainer.maximumNumberOfLines = 10
        originalHistoryText.textContainer.lineBreakMode = .byTruncatingTail
        originalHistoryText.isEditable = false
        originalHistoryText.isSelectable = false
        originalHistoryText.isScrollEnabled = false
        originalHistoryText.textContainerInset = UIEdgeInsets(top: 10, left: 16, bottom: 10, right: 16)
    }
    
    private func layoutUI() {
        
        originalHistoryText.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(originalHistoryText)
                
        NSLayoutConstraint.activate([
            
            originalHistoryText.topAnchor.constraint(equalTo: self.topAnchor),
            originalHistoryText.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            originalHistoryText.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            originalHistoryText.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    func setupCell(originalHistoryItem: String) {
        originalHistoryText.text = originalHistoryItem
    }
}

protocol EditHistoryNavigationBarDelegate: AnyObject {
    func didFinishTappingBackButton()
}

class EditHistoryNavigationBar: UIView {
    
    private let grabberPill = UIView()
    private let backButton = NavigationBarCircleButton()
    private let gradientBackground = CAGradientLayer()
    
    weak var delegate: EditHistoryNavigationBarDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureView()
        layoutUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setGradientBackgroundAndAddCornerRadius()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setGradientBackgroundAndAddCornerRadius() {
        
        gradientBackground.frame = self.bounds
        
        grabberPill.layer.cornerRadius = (grabberPill.frame.height / 2.0)
        grabberPill.clipsToBounds = true
    }
    
    private func configureView() {
        
        self.backgroundColor = .clear
        
        grabberPill.backgroundColor = .miscellaneous.grabber
        backButton.setImageForButton(imageName: "chevron.left", size: 20)
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        
        if let color = UIColor.background.primary?.cgColor {
            
            gradientBackground.colors = [color, UIColor.clear.cgColor]
        }
        
        gradientBackground.locations = [0.6, 1.0]
    }
    
    private func layoutUI() {
        
        grabberPill.translatesAutoresizingMaskIntoConstraints = false
        backButton.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(grabberPill)
        self.addSubview(backButton)
        self.layer.insertSublayer(gradientBackground, at: 0)
        
        let padding = 18.0
        let multiplier = 0.55
        
        NSLayoutConstraint.activate([
            
            grabberPill.topAnchor.constraint(equalTo: self.topAnchor, constant: 15),
            grabberPill.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            grabberPill.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.2),
            grabberPill.heightAnchor.constraint(equalToConstant: 5),
            
            backButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            backButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            backButton.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: multiplier),
            backButton.widthAnchor.constraint(equalTo: self.heightAnchor, multiplier: multiplier)
        ])
    }
    
    @objc private func backButtonTapped() {
        delegate?.didFinishTappingBackButton()
    }
}
