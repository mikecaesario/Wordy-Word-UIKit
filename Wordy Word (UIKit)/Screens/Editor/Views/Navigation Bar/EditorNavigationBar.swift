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
    private let gradientBackground = CAGradientLayer()
    
    private var navigationTitleText = "Wordy Word"
    
    weak var delegate: EditorNavigationBarDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        prepareView()
        layoutUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setGradientBackgroundFrame()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setNavBarTitle(title: EditingStyleEnum?) {
        
        guard let title = title else { return }
        
        navigationTitle.text = title.rawValue
    }
    
    private func setGradientBackgroundFrame() {
        
        gradientBackground.frame = self.bounds
    }
    
    private func prepareView() {
        
        navigationTitle.text = navigationTitleText
        editorMenuButton.addTarget(self, action: #selector(showEditorMenu), for: .touchUpInside)
        
        editorMenuButton.setImageForButton(imageName: "slider.horizontal.3", size: 20)
        
        if let color = UIColor.background.primary?.cgColor {

            gradientBackground.colors = [color, UIColor.clear.cgColor]
        }

        gradientBackground.locations = [0.35, 1.0]
    }
    
    private func layoutUI() {
        
        navigationTitle.translatesAutoresizingMaskIntoConstraints = false
        editorMenuButton.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(navigationTitle)
        self.addSubview(editorMenuButton)
        self.layer.insertSublayer(gradientBackground, at: 0)
                
        let padding = 16.0
        
        NSLayoutConstraint.activate([
            
            navigationTitle.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -10),
            navigationTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            navigationTitle.trailingAnchor.constraint(equalTo: editorMenuButton.leadingAnchor, constant: -10),
            
            editorMenuButton.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -10),
            editorMenuButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            editorMenuButton.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.75),
            editorMenuButton.widthAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.75),

        ])
    }
}

extension EditorNavigationBar {
    
    @objc private func showEditorMenu() {
        
        delegate?.didTapMenuButton()
    }
}
