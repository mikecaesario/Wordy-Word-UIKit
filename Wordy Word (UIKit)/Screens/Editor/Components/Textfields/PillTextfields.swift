//
//  PillTextfields.swift
//  Wordy Word (UIKit)
//
//  Created by Michael Caesario on 23/05/23.
//

import UIKit

class PillTextfields: UITextField {

    let inset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = (self.frame.height / 2.0)
        clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: inset)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: inset)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: inset)
    }
    
    private func configure() {
        
        font = UIFont.systemFont(ofSize: 18, weight: .medium)
        backgroundColor = .background.secondary
        tintColor = .accent.secondary
        textAlignment = .left
        autocapitalizationType = .none
        autocorrectionType = .no
    }
}
