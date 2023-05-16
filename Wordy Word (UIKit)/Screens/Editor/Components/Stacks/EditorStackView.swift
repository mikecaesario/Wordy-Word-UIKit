//
//  EditorStackView.swift
//  WordyWord (UIKit)
//
//  Created by Michael Caesario on 01/05/23.
//

import UIKit

class EditorStackView: UIStackView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        axis = .vertical
        spacing = 5
        distribution = .fill
        alignment = .leading
        layoutMargins = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        isLayoutMarginsRelativeArrangement = true
    }
}
