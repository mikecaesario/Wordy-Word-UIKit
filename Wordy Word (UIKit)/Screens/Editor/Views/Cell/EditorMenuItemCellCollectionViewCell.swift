//
//  EditorMenuItemCellCollectionViewCell.swift
//  Wordy Word (UIKit)
//
//  Created by Michael Caesario on 29/05/23.
//

import UIKit

class EditorMenuItemCellCollectionViewCell: UICollectionViewCell {
    
    private let editingStyleImage = UIImageView()
    private let editingStyleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureView()
        layoutUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
                
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(image: String, label: String) {
        editingStyleImage.image = UIImage(systemName: image)
        editingStyleLabel.text = label
    }
    
    private func configureView() {
        editingStyleImage.backgroundColor = .button.secondary
        editingStyleImage.layer.cornerRadius = (self.frame.size.width / 2.0)
        editingStyleImage.layer.masksToBounds = true
        
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
