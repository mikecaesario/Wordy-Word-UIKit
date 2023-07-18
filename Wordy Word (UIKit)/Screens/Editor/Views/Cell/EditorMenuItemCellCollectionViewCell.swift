//
//  EditorMenuItemCellCollectionViewCell.swift
//  Wordy Word (UIKit)
//
//  Created by Michael Caesario on 29/05/23.
//

import UIKit

class EditorMenuItemCellCollectionViewCell: UICollectionViewCell {
    
    private let editingStyleImage = ImageButtonForEditorMenuItemCell()
    private let editingStyleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureView()
        layoutUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(image: String, label: String) {
        
        editingStyleImage.setImage(imageName: image)
        editingStyleLabel.text = label
    }
    
    func isCurrentlySelected(style: Bool) {
        
        if style {
            editingStyleImage.setColor(backgroundColor: .button.primary, imageColor: .text.black)
        } else {
            editingStyleImage.setColor(backgroundColor: .button.secondary, imageColor: .text.white)
        }
    }
    
    private func configureView() {
        
        editingStyleLabel.font = UIFont(name: "Poppins-Medium", size: 14)
        editingStyleLabel.minimumScaleFactor = 0.7
        editingStyleLabel.textColor = .text.white
        editingStyleLabel.textAlignment = .center
    }
    
    private func layoutUI() {
        
        editingStyleImage.translatesAutoresizingMaskIntoConstraints = false
        editingStyleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(editingStyleImage)
        self.addSubview(editingStyleLabel)
        
        NSLayoutConstraint.activate([
        
            editingStyleImage.topAnchor.constraint(equalTo: self.topAnchor),
            editingStyleImage.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            editingStyleImage.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            editingStyleImage.heightAnchor.constraint(equalTo: self.widthAnchor),
            
            editingStyleLabel.topAnchor.constraint(equalTo: editingStyleImage.bottomAnchor),
            editingStyleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            editingStyleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            editingStyleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
}

class ImageButtonForEditorMenuItemCell: UIView {

    let image = UIImageView()

    override init(frame: CGRect) {

        super.init(frame: frame)
        prepareView()
        layoutUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {

        self.layer.cornerRadius = self.frame.height / 2.0
        self.layer.masksToBounds = true
    }

    private func prepareView() {

        image.contentMode = .center
    }

    private func layoutUI() {

        image.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(image)

        let padding = 22.0
        
        NSLayoutConstraint.activate([
            
            image.topAnchor.constraint(equalTo: self.topAnchor, constant: padding),
            image.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            image.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -padding),
            image.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
        ])
    }
    
    func setImage(imageName: String) {
        
        let config = UIImage.SymbolConfiguration(pointSize: 33, weight: .medium)
        image.image = UIImage(systemName: imageName, withConfiguration: config)?.withRenderingMode(.alwaysTemplate)
    }
    
    func setColor(backgroundColor: UIColor?, imageColor: UIColor?) {
        
        guard let backgroundColor = backgroundColor, let imageColor = imageColor else { return }
        
        self.backgroundColor = backgroundColor
        image.tintColor = imageColor
    }
}

