//  
//  Toast.swift
//  Wordy Word (UIKit)
//
//  Created with ❤️‍🔥 by Michael Caesario on 11/12/23.
//  Copyright © 2023 Michael Caesario. All rights reserved.
// 
//  Website: https://mikecaesario.app
//  GitHub: https://github.com/mikecaesario
//  LinkedIn: https://www.linkedin.com/in/mikecaesario/
//

import UIKit

final class Toast: UIView {
        
    let image = UIImageView()
    let message = UITextView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureView()
        layoutView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.cornerRadius = (self.frame.height / 2.0)

    }
    
    private func configureView() {
        
        self.backgroundColor = .link
        
        self.image.tintColor = .white.withAlphaComponent(0.5)
        
        self.message.textColor = .white
        self.message.textAlignment = .left
        self.message.font = UIFont.systemFont(ofSize: 17)
        self.message.isSelectable = false
        self.message.isScrollEnabled = false
        self.message.isEditable = false
        self.message.backgroundColor = .clear
    }
    
    private func layoutView() {
        
        self.image.translatesAutoresizingMaskIntoConstraints = false
        self.message.translatesAutoresizingMaskIntoConstraints = false

        self.addSubviews([image, message])
        
        NSLayoutConstraint.activate([
            
            image.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            image.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 26),
            image.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.4),
            image.widthAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.4),

            message.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            message.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 10),
            message.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    
    func configureToast(withType: ToastTypeEnum) {
        
        self.image.image = UIImage(systemName: withType.symbol)
        self.message.text = withType.message
    }
}
