//
//  EditorTextView.swift
//  WordyWord (UIKit)
//
//  Created by Michael Caesario on 30/04/23.
//

import UIKit

class EditorTextView: UITextView {

    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        font = UIFont.systemFont(ofSize: 20, weight: .medium)
        textColor = .text.black
        textAlignment = .left
        backgroundColor = .clear
        showsVerticalScrollIndicator = false
        contentInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    }
}
