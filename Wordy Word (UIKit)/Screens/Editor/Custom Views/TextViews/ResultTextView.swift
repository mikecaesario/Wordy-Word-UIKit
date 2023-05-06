//
//  ResultTextView.swift
//  Wordy Word (UIKit)
//
//  Created by Michael Caesario on 06/05/23.
//

import UIKit

class ResultTextView: UITextView {

    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        font = UIFont(name: "Poppins-SemiBold", size: 28)
        textColor = .text.white
        textAlignment = .left
        backgroundColor = .clear
        showsVerticalScrollIndicator = false
        contentInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    }
}
