//
//  EditorNavigationBar.swift
//  Wordy Word (UIKit)
//
//  Created by Michael Caesario on 03/05/23.
//

import UIKit

protocol EditorNavigationBarDelegate: AnyObject {
    func didTapMenuButton()
}

class EditorNavigationBar: UIView {

    private let navigationTitle = NavigationBarLabel()
    private let editorMenuButton: UIButton = {
        let button = UIButton()
        let config = UIImage.SymbolConfiguration(pointSize: 22, weight: .light, scale: .small)
        button.setImage(UIImage(systemName: "slider.horizontal.3", withConfiguration: config), for: .normal)
        button.backgroundColor = .background.thirtiary
        button.tintColor = .text.white
        button.layer.cornerRadius = 28
        button.layer.masksToBounds = true
        return button
    }()
    
    private let stack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.distribution = .fillProportionally
        stack.spacing = 20
        return stack
    }()
    
    private var navigationTitleText = "Wordy Word"
    
    weak var delegate: EditorNavigationBarDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        prepareView()
        configureView()
        layoutUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func prepareView() {
        
        navigationTitle.text = navigationTitleText
        editorMenuButton.addTarget(self, action: #selector(showEditorMenu), for: .touchUpInside)
    }
    
    private func configureView() {
        
        self.backgroundColor = .clear
    }
    
    private func layoutUI() {
        
        navigationTitle.translatesAutoresizingMaskIntoConstraints = false
        editorMenuButton.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(navigationTitle)
        self.addSubview(editorMenuButton)
        
        NSLayoutConstraint.activate([
            
            navigationTitle.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            navigationTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            navigationTitle.trailingAnchor.constraint(equalTo: editorMenuButton.trailingAnchor, constant: -10),
            
            editorMenuButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            editorMenuButton.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            editorMenuButton.heightAnchor.constraint(equalToConstant: 56),
            editorMenuButton.widthAnchor.constraint(equalToConstant: 56)
        ])
    }
}

extension EditorNavigationBar {
    
    @objc private func showEditorMenu() {
        delegate?.didTapMenuButton()
    }
}
