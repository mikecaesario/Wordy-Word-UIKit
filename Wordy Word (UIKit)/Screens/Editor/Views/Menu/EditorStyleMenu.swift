//
//  EditorStyleMenu.swift
//  Wordy Word (UIKit)
//
//  Created by Michael Caesario on 28/05/23.
//

import UIKit

protocol EditorStyleMenuDelegate: AnyObject {
    func didFinishPickingEditingStyle(style: EditingStyleEnum?)
}

class EditorStyleMenu: UIView {

    private let editingStyleMenu = UICollectionView()
    private let cancelButton = UIButton()
    
    private let blurView = UIVisualEffectView(effect: UIBlurEffect(style: .systemThinMaterialDark))
    
    private let cell = "editingMenuItemCell"
    private let buttonSize = 60.0
    
    weak var delegate: EditorStyleMenuDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureView()
        configureCollectionView()
        layoutUI()
        animateView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView() {
        
        backgroundColor = .clear
        
    }
    
    private func configureCollectionView() {
        
        editingStyleMenu.delegate = self
        editingStyleMenu.dataSource = self
        
        editingStyleMenu.register(EditorMenuItemCellCollectionViewCell.self, forCellWithReuseIdentifier: cell)
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: self.frame.width / 4, height: 60)
        
        editingStyleMenu.collectionViewLayout = layout
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
            
            cancelButton.heightAnchor.constraint(equalToConstant: buttonSize),
            cancelButton.widthAnchor.constraint(equalToConstant: buttonSize),
            cancelButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            cancelButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding)
        ])
    }
    
    private func animateView() {
        
    }
    
    private func findEditingStyleEnum(indexPath: Int) -> EditingStyleEnum? {
        
        switch indexPath {
        case 0: return .capitalize
        case 1: return .title
        case 2: return .upper
        case 3: return .lower
        case 4: return .replace
        case 5: return .remove
        case 6: return .reverse
        default: return nil
        }
    }
    
    private func findEditingStyleEnumImage(indexPath: Int) -> EditingStyleEnum.EditingStyleEnumImage? {
        
        switch indexPath {
        case 0: return .capitalize
        case 1: return .title
        case 2: return .upper
        case 3: return .lower
        case 4: return .replace
        case 5: return .remove
        case 6: return .reverse
        default: return nil
        }
    }
}

extension EditorStyleMenu: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return EditingStyleEnum.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cell, for: indexPath) as? EditorMenuItemCellCollectionViewCell {
            
            if let image = findEditingStyleEnumImage(indexPath: indexPath.row)?.rawValue, let label = findEditingStyleEnum(indexPath: indexPath.row)?.rawValue {
                
                cell.configureCell(image: image, label: label)
            }
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        collectionView.deselectItem(at: indexPath, animated: true)
        
        delegate?.didFinishPickingEditingStyle(style: findEditingStyleEnum(indexPath: indexPath.row))
    }
    
}
