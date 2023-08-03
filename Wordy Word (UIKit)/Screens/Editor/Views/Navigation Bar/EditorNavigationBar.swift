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
    private let editorMenuButton = NavigationBarCircleButton()
    
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
    
    func setNavBarTitle(title: EditingStyleEnum?) {
        
        guard let title = title else { return }
        
        navigationTitle.text = title.rawValue
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
            navigationTitle.trailingAnchor.constraint(equalTo: editorMenuButton.leadingAnchor, constant: -10),
            
            editorMenuButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            editorMenuButton.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            editorMenuButton.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.85),
            editorMenuButton.widthAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.85),

        ])
    }
}

extension EditorNavigationBar {
    
    @objc private func showEditorMenu() {
        delegate?.didTapMenuButton()
    }
}
