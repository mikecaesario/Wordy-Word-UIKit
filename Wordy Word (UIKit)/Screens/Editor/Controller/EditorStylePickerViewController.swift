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
    
    private let editorPickerUICollectionViewButton = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    private let collectionViewLayout = UICollectionViewFlowLayout()
    private let cancelButton = CancelButton()
    
    private let reusableCellIdentifier = "EditorMenuCell"
    private let currentSelectedStyle: EditingStyleEnum?
    
    weak var delegate: EditorStylePickerViewControllerDelegate?
    
    init(currentSelectedStyle: EditingStyleEnum?, delegate: EditorStylePickerViewControllerDelegate? = nil) {
        self.currentSelectedStyle = currentSelectedStyle
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        
        collectionViewLayout.scrollDirection = .vertical
        
        editorPickerUICollectionViewButton.backgroundColor = .clear
        editorPickerUICollectionViewButton.setCollectionViewLayout(collectionViewLayout, animated: true)
        editorPickerUICollectionViewButton.register(EditorMenuItemCellCollectionViewCell.self, forCellWithReuseIdentifier: reusableCellIdentifier)
        
        editorPickerUICollectionViewButton.delegate = self
        editorPickerUICollectionViewButton.dataSource = self
    }
    
    private func animateView() {
        
    }
    
    private func didTappedEditorStyleCell(indexPath: IndexPath) {
                
        let style = findEditingStyleEnum(indexPath: indexPath)
        
        delegate?.didFinishPickingEditingStyle(style: style)
    }
    
    @objc private func didTappedCancelButton() {
        
        delegate?.didTappedCancelButton()
    }
    
    private func findEditingStyleEnum(indexPath: IndexPath) -> EditingStyleEnum? {
        
        switch indexPath.section {
        case 0:
            
            switch indexPath.row {
            case 0: return .capitalize
            case 1: return .title
            case 2: return .upper
            default: return nil
            }
            
        case 1:
            
            switch indexPath.row {
            case 0: return .lower
            case 1: return .replace
            case 2: return .remove
            default: return nil
            }
            
        case 2:
            
            switch indexPath.row {
            case 0: return .reverse
            default: return nil
            }
            
        default: return nil
        }
    }
    
    private func findEditingStyleEnumImage(indexPath: IndexPath) -> EditingStyleEnum.EditingStyleEnumImage? {
        
        switch indexPath.section {
        case 0:
            
            switch indexPath.row {
            case 0: return .capitalize
            case 1: return .title
            case 2: return .upper
            default: return nil
            }
            
        case 1:
            
            switch indexPath.row {
            case 0: return .lower
            case 1: return .replace
            case 2: return .remove
            default: return nil
            }
            
        case 2:
            
            switch indexPath.row {
            case 0: return .reverse
            default: return nil
            }
            
        default: return nil
        }
    }
}

// MARK: -  View Setup

extension EditorStylePickerViewController {
    
    private func configureView() {
        
        view.backgroundColor = .clear
        
        cancelButton.addTarget(self, action: #selector(didTappedCancelButton), for: .touchUpInside)
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
        let collectionViewPadding = 35.0
       
        NSLayoutConstraint.activate([
            
            currentEditingStyleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding),
            currentEditingStyleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            editorPickerUICollectionViewButton.topAnchor.constraint(equalTo: currentEditingStyleLabel.bottomAnchor, constant: collectionViewPadding),
            editorPickerUICollectionViewButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            editorPickerUICollectionViewButton.bottomAnchor.constraint(equalTo: cancelButton.topAnchor, constant: -collectionViewPadding),
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
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch section {
        case 0: return 3
        case 1: return 3
        case 2: return 1
        default: return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = editorPickerUICollectionViewButton.dequeueReusableCell(withReuseIdentifier: reusableCellIdentifier, for: indexPath) as! EditorMenuItemCellCollectionViewCell
        
        cell.isCurrentlySelected(style: currentSelectedStyle == findEditingStyleEnum(indexPath: indexPath))
        
        if let label = findEditingStyleEnum(indexPath: indexPath), let image = findEditingStyleEnumImage(indexPath: indexPath) {
            cell.configureCell(image: image.rawValue, label: label.rawValue)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        collectionView.deselectItem(at: indexPath, animated: true)
        
        didTappedEditorStyleCell(indexPath: indexPath)
    }
}

extension EditorStylePickerViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let screenSizeWidthForCell = view.bounds.width / 4

        return CGSize(width: screenSizeWidthForCell, height: screenSizeWidthForCell + 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
                
        let numberOfItemsInSection = collectionView.numberOfItems(inSection: section)

        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        
        let totalCollectionViewWidth = collectionView.frame.width
        let cellWidth = layout.itemSize.width
        let centerLoneCellInsets = (totalCollectionViewWidth / 2) - cellWidth
        
        let verticalPaddingForCells = 15.0
                
        switch numberOfItemsInSection {
        case 1:
            return UIEdgeInsets(top: verticalPaddingForCells, left: centerLoneCellInsets, bottom: verticalPaddingForCells, right: 0)
        default:
            return UIEdgeInsets(top: verticalPaddingForCells, left: 0, bottom: verticalPaddingForCells, right: 0)
        }

    }
}

class CancelButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        prepareButton()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = self.frame.height / 2
        layer.masksToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func prepareButton() {
        let config = UIImage.SymbolConfiguration(pointSize: 24, weight: .medium, scale: .medium)
        backgroundColor = .button.primary
        setImage(UIImage(systemName: "xmark", withConfiguration: config), for: .normal)
        tintColor = .text.black
    }
}