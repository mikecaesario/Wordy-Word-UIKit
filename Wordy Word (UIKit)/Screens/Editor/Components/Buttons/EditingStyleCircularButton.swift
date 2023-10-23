//  
//  EditingStyleCircularButton.swift
//  Wordy Word (UIKit)
//
//  Created with ❤️‍🔥 by Michael Caesario on 19/10/23.
//  Copyright © 2023 Michael Caesario. All rights reserved.
// 
//  Website: https://mikecaesario.app
//  GitHub: https://github.com/mikecaesario
//  LinkedIn: https://www.linkedin.com/in/mikecaesario/
//

import UIKit

class EditingStyleCircularButton: UIButton {

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
