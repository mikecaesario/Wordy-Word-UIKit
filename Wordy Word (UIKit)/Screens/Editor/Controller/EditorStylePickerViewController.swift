//
//  EditorStylePickerViewController.swift
//  Wordy Word (UIKit)
//
//  Created by Michael Caesario on 24/06/23.
//

import UIKit

protocol EditorStylePickerViewControllerDelegate: AnyObject {
    func didFinishPickingEditingStyle(style: EditingStyleEnum?) 
    func didTappedCancelButton()
}

class EditorStylePickerViewController: UIViewController {

    private let currentEditingStyleLabel: UILabel = {
        let label = UILabel()
        label.text = "Select Style"
        label.font = UIFont(name: "Poppins-Medium", size: 28)
        label.textColor = .text.white
        label.minimumScaleFactor = 0.7
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let editorPickerUICollectionViewButton = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewLayout())
    private let collectionViewLayout = UICollectionViewFlowLayout()
    
    private let cancelButton: UIButton = {
        let config = UIImage.SymbolConfiguration(pointSize: 24, weight: .medium, scale: .medium)
        let button = UIButton()
        button.backgroundColor = .button.secondary
        button.setImage(UIImage(systemName: "xmark", withConfiguration: config), for: .normal)
        button.tintColor = .text.white
        return button
    }()
    
    weak var delegate: EditorStylePickerViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
        addBlurBackground()
        configureCollectionView()
        layoutUI()
    }
    
    deinit {
        print("DEINITIALIZING EDITOR STYLE PICKER")
    }
    
    private func configureCollectionView() {
        
//        collectionViewLayout.minimumLineSpacing = 10
        collectionViewLayout.scrollDirection = .vertical
        
        editorPickerUICollectionViewButton.backgroundColor = .clear
        editorPickerUICollectionViewButton.setCollectionViewLayout(collectionViewLayout, animated: true)
        editorPickerUICollectionViewButton.register(EditorMenuItemCellCollectionViewCell.self, forCellWithReuseIdentifier: "EditorMenuCell")
        
        editorPickerUICollectionViewButton.delegate = self
        editorPickerUICollectionViewButton.dataSource = self
    }
    
    private func animateView() {
        
    }
    
    private func didTappedEditorStyleCell(indexPath: Int) {
                
        let style = findEditingStyleEnum(indexPath: indexPath)
        
        delegate?.didFinishPickingEditingStyle(style: style)
    }
    
    @objc private func tappedCancelButton() {
        
        delegate?.didTappedCancelButton()
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

// MARK: -  View Setup

extension EditorStylePickerViewController {
    
    private func configureView() {
        
        view.backgroundColor = .clear
        
        cancelButton.addTarget(self, action: #selector(tappedCancelButton), for: .touchUpInside)
    }
    
    private func addBlurBackground() {
        
        let blurEffect = UIBlurEffect(style: .systemThinMaterialDark)
        let blurBackground = UIVisualEffectView(effect: blurEffect)
        blurBackground.translatesAutoresizingMaskIntoConstraints = false
        blurBackground.frame = view.bounds
        view.insertSubview(blurBackground, at: 0)
    }
    
    private func layoutUI() {
        
        currentEditingStyleLabel.translatesAutoresizingMaskIntoConstraints = false
        editorPickerUICollectionViewButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(currentEditingStyleLabel)
        view.addSubview(editorPickerUICollectionViewButton)
        view.addSubview(cancelButton)

        let screenWidthDivided = (view.bounds.width / 4.2)
        let padding = 16.0
       
        NSLayoutConstraint.activate([
            
            currentEditingStyleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding),
            currentEditingStyleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            editorPickerUICollectionViewButton.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            editorPickerUICollectionViewButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            editorPickerUICollectionViewButton.bottomAnchor.constraint(equalTo: cancelButton.topAnchor, constant: padding),
            editorPickerUICollectionViewButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            
            cancelButton.heightAnchor.constraint(equalToConstant: screenWidthDivided),
            cancelButton.widthAnchor.constraint(equalToConstant: screenWidthDivided),
            cancelButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            cancelButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -padding)
        ])
    }
}

// MARK: - UICollectionView Delegate

extension EditorStylePickerViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return EditingStyleEnum.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = editorPickerUICollectionViewButton.dequeueReusableCell(withReuseIdentifier: "EditorMenuCell", for: indexPath) as! EditorMenuItemCellCollectionViewCell
        
        if let label = findEditingStyleEnum(indexPath: indexPath.row), let image = findEditingStyleEnumImage(indexPath: indexPath.row) {
            cell.configureCell(image: image.rawValue, label: label.rawValue)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        collectionView.deselectItem(at: indexPath, animated: true)
        
        didTappedEditorStyleCell(indexPath: indexPath.row)
    }
}

extension EditorStylePickerViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let screenSizeWidthForCell = view.bounds.width / 4.2
        
        return CGSize(width: screenSizeWidthForCell, height: screenSizeWidthForCell + 20)
    }
}
