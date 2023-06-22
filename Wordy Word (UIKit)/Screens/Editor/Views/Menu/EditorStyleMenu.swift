//
//  EditorStyleMenu.swift
//  Wordy Word (UIKit)
//
//  Created by Michael Caesario on 28/05/23.
//

import UIKit

protocol EditorStyleMenuDelegate: AnyObject {
    func didFinishPickingEditingStyle(style: EditingStyleEnum?)
    func didTappedCancelButton()
}

class EditorStyleMenu: UIView {

    private let currentEditingStyleLabel: UILabel = {
        let label = UILabel()
        label.text = "Select Style"
        label.font = UIFont(name: "Poppins-Medium", size: 26)
        label.textColor = .text.white
        label.minimumScaleFactor = 0.7
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
//    
//    private let editingStyleMenuCollectionView: UICollectionView = {
//        let layout = UICollectionViewFlowLayout()
//        layout.scrollDirection = .vertical
//        let collection = UICollectionView()
//        collection.collectionViewLayout = layout
//        collection.register(EditorMenuItemCellCollectionViewCell.self, forCellWithReuseIdentifier: "editingMenuItemCell")
//        collection.translatesAutoresizingMaskIntoConstraints = false
//        return collection
//    }()
//    
    private let cancelButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .button.secondary
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = .text.white
        return button
    }()
        
    private let cell = "editingMenuItemCell"
    
    weak var delegate: EditorStyleMenuDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureView()
//        configureCollectionView()
        addBlurBackground()
        layoutUI()
        animateView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let width = self.bounds.width
        print("WIDTH = \(width)")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        
        print("DEINITIALIZING")
//        editingStyleMenu.delegate = nil
//        editingStyleMenu.dataSource = nil
    }
    
    private func configureView() {
        
        backgroundColor = .clear
//        blurBackground.layer.zPosition = -1
        
        cancelButton.addTarget(self, action: #selector(tappedCancelButton), for: .touchUpInside)
//        cancelButton.layer.cornerRadius = self.bounds.height / 2.0
//        cancelButton.layer.masksToBounds = true
    }
    
//    private func configureCollectionView() {
//
//        editingStyleMenu.delegate = self
//        editingStyleMenu.dataSource = self
//
//        editingStyleMenu.register(EditorMenuItemCellCollectionViewCell.self, forCellWithReuseIdentifier: cell)
//
//        let layout = UICollectionViewFlowLayout()
//        layout.scrollDirection = .horizontal
//
//        editingStyleMenu.collectionViewLayout = layout
//    }
    
    private func addBlurBackground() {
        
        let blurEffect = UIBlurEffect(style: .systemThinMaterialDark)
        let blurBackground = UIVisualEffectView(effect: blurEffect)
        blurBackground.translatesAutoresizingMaskIntoConstraints = false
        self.insertSubview(blurBackground, at: 0)
        
        NSLayoutConstraint.activate([
        
            blurBackground.topAnchor.constraint(equalTo: self.topAnchor),
            blurBackground.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            blurBackground.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            blurBackground.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
    
    private func layoutUI() {
        
        currentEditingStyleLabel.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(currentEditingStyleLabel)
        self.addSubview(cancelButton)

//        editingStyleMenu.translatesAutoresizingMaskIntoConstraints = false
        
//        self.addSubview(editingStyleMenu)
//        cancelButton.layer.zPosition = 1
//
        let padding = 15.0
//        
        NSLayoutConstraint.activate([
            
            currentEditingStyleLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: padding),
            currentEditingStyleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
//            editingStyleMenu.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.5),
//            editingStyleMenu.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
//            editingStyleMenu.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
//            editingStyleMenu.bottomAnchor.constraint(equalTo: cancelButton.topAnchor, constant: padding),
//            
            cancelButton.heightAnchor.constraint(equalToConstant: 60),
            cancelButton.widthAnchor.constraint(equalToConstant: 60),
            cancelButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            cancelButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -padding)
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
    
    @objc private func tappedCancelButton() {
        delegate?.didTappedCancelButton()
    }
}

//extension EditorStyleMenu: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
//    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return EditingStyleEnum.allCases.count
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cell, for: indexPath) as! EditorMenuItemCellCollectionViewCell
//        
//        if let image = findEditingStyleEnumImage(indexPath: indexPath.row)?.rawValue, let label = findEditingStyleEnum(indexPath: indexPath.row)?.rawValue {
//            
//            cell.configureCell(image: image, label: label)
//        }
//        
//        return cell
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        
//        collectionView.deselectItem(at: indexPath, animated: true)
//        
//        delegate?.didFinishPickingEditingStyle(style: findEditingStyleEnum(indexPath: indexPath.row))
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        
//        let screenWidthForCellSize = self.bounds.width / 4.2
//        
//        return CGSize(width: screenWidthForCellSize, height: screenWidthForCellSize)
//    }
//}
