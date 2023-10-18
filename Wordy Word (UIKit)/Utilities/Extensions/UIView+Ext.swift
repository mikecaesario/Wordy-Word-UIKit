//
//  UIView+Ext.swift
//  Wordy Word (UIKit)
//
//  Created by Michael Caesario on 25/09/23.
//

import UIKit

extension UIView {
    
    func addSubviews(_ views: [UIView]) {
        
        for i in views {
            self.addSubview(i)
        }
    }
    
    func animateButtonOnSuccess(sender: UIButton, onAnimationText: String, onAnimationGlyph: String, onAnimationColor: UIColor, borderColor: UIColor?, originalText: String, originalGlyph: String, originalColor: UIColor) {
        
        UIView.transition(with: sender, duration: 0.5, options: [.curveEaseIn, .transitionFlipFromBottom]) {
            
            sender.setTitle(onAnimationText, for: .normal)
            sender.setImage(UIImage(systemName: onAnimationGlyph), for: .normal)
            sender.backgroundColor = onAnimationColor
            sender.setTitleColor(.text.white, for: .normal)
            sender.tintColor = .text.white
            sender.layer.borderWidth = 1.0
            
            if let color = UIColor.text.grey?.cgColor {
                sender.layer.borderColor = color
            }
        } completion: { _ in
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                
                UIView.transition(with: sender, duration: 0.5, options: [.curveEaseOut, .transitionFlipFromTop]) {
                    sender.setTitle("Copy", for: .normal)
                    sender.setImage(UIImage(systemName: "doc.on.doc"), for: .normal)
                    sender.backgroundColor = .button.copy
                    sender.setTitleColor(.text.white, for: .normal)
                    sender.tintColor = .text.white
                    sender.layer.borderWidth = 0
                }
            }
        }
    }
}
