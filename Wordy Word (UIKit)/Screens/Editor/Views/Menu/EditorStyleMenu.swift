//
//  EditorStyleMenu.swift
//  Wordy Word (UIKit)
//
//  Created by Michael Caesario on 28/05/23.
//

import UIKit

protocol EditorStyleMenuDelegate: AnyObject {
    func didFinishPickingEditingStyle(style: EditingStyleEnum)
}

class EditorStyleMenu: UIView {

    private let editingStyleMenu = UICollectionView()
    private let cancelButton = UIButton()
    
    private let blurView = UIVisualEffectView(effect: UIBlurEffect(style: .systemThinMaterialDark))
    
    private var selectedEditingStyle: EditingStyleEnum?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureView()
        layoutUI()
        animateView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView() {
        
        backgroundColor = .clear
        editingStyleMenu.delegate = self
        editingStyleMenu.dataSource = self
    }
    
    private func layoutUI() {
        
        editingStyleMenu.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        
        blurView.bounds = self.bounds
        
        self.addSubview(blurView)
        self.addSubview(editingStyleMenu)
        self.addSubview(cancelButton)
        
        let padding = 15.0
        
        NSLayoutConstraint.activate([
            editingStyleMenu.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.5),
            editingStyleMenu.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            editingStyleMenu.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            editingStyleMenu.bottomAnchor.constraint(equalTo: cancelButton.topAnchor, constant: padding),
            
            cancelButton.heightAnchor.constraint(equalToConstant: 50),
            cancelButton.widthAnchor.constraint(equalToConstant: 50),
            cancelButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            cancelButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding)
        ])
    }
    
    private func animateView() {
        
    }
}

extension EditorStyleMenu: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return EditingStyleEnum.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = 
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}
