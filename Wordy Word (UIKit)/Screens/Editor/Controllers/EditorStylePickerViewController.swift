//
//  EditorStylePickerViewController.swift
//  Wordy Word (UIKit)
//
//  Created by Michael Caesario on 24/06/23.
//

import UIKit

protocol EditorStylePickerViewControllerDelegate: AnyObject {
    func didFinishPickingEditingStyle(style: EditingStyleEnum?)
//    func didTappedCancelButton()
}

class EditorStylePickerViewController: UIViewController {

    private let currentEditingStyleLabel = UILabel()
    private let editorPickerUICollectionViewButton = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    private let collectionViewLayout = UICollectionViewFlowLayout()
    private let cancelButton = CancelButton()
    
    private let currentSelectedStyle: EditingStyleEnum?
    
    weak var delegate: EditorStylePickerViewControllerDelegate?
    
    init(currentSelectedStyle: EditingStyleEnum?) {
        self.currentSelectedStyle = currentSelectedStyle
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
    
    override func viewWillAppear(_ animated: Bool) {

        editorPickerUICollectionViewButton.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)

        editorPickerUICollectionViewButton.alpha = 0
    }

    override func viewDidAppear(_ animated: Bool) {

        animateCollectionView()
    }
    
    deinit {
        print("DEINITIALIZING EDITOR STYLE PICKER")
    }
    
    private func didTappedEditorStyleCell(indexPath: IndexPath) {
                
        let style = findEditingStyleEnum(indexPath: indexPath)
        let haptic = UIImpactFeedbackGenerator(style: .medium)
        
        haptic.impactOccurred()
        delegate?.didFinishPickingEditingStyle(style: style)
        self.dismiss(animated: true)
    }
    
    @objc private func didTappedCancelButton() {
        self.dismiss(animated: true)
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
        
        currentEditingStyleLabel.text = "Select Style"
        currentEditingStyleLabel.font = UIFont(name: .fonts.poppinsMedium, size: 28)
        currentEditingStyleLabel.textColor = .text.white
        currentEditingStyleLabel.minimumScaleFactor = 0.7
        currentEditingStyleLabel.textAlignment = .center
        currentEditingStyleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        cancelButton.addTarget(self, action: #selector(didTappedCancelButton), for: .touchUpInside)
    }
    
    private func configureCollectionView() {
        
        let verticalBounds = view.frame.height / 12
        let horizontalPadding = 10.0
        
        collectionViewLayout.scrollDirection = .vertical
        
        editorPickerUICollectionViewButton.backgroundColor = .clear
        editorPickerUICollectionViewButton.setCollectionViewLayout(collectionViewLayout, animated: true)
        editorPickerUICollectionViewButton.register(EditorMenuItemCellCollectionViewCell.self, forCellWithReuseIdentifier: EditorMenuItemCellCollectionViewCell.reuseIdentifier)
        editorPickerUICollectionViewButton.contentInset = UIEdgeInsets(top: verticalBounds, left: horizontalPadding, bottom: verticalBounds, right: horizontalPadding)
        
        editorPickerUICollectionViewButton.delegate = self
        editorPickerUICollectionViewButton.dataSource = self
    }
    
    private func animateCollectionView() {
        
        let animator = UIViewPropertyAnimator(duration: 0.1, curve: .easeIn)
        
        animator.addAnimations {
            self.editorPickerUICollectionViewButton.alpha = 1.0
        }
        
        animator.addAnimations {
            self.editorPickerUICollectionViewButton.transform = .identity
        }
        
        animator.startAnimation()
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

        view.addSubviews([currentEditingStyleLabel, editorPickerUICollectionViewButton, cancelButton])

        let screenWidthDivided = (view.bounds.width / 4.2)
        let padding = 16.0
        let collectionViewPadding = 0.0
       
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
        
        guard let cell = editorPickerUICollectionViewButton.dequeueReusableCell(withReuseIdentifier: EditorMenuItemCellCollectionViewCell.reuseIdentifier, for: indexPath) as? EditorMenuItemCellCollectionViewCell else {
            fatalError("ERROR: Editor Menu Item Cell Not Found")
        }
        
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
        
        let totalCollectionViewWidth = collectionView.frame.width + 20
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
        let config = UIImage.SymbolConfiguration(pointSize: 28, weight: .medium, scale: .medium)
        backgroundColor = .button.cancel
        setImage(UIImage(systemName: "xmark", withConfiguration: config), for: .normal)
        tintColor = .text.black
    }
}
