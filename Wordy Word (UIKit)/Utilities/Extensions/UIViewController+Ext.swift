//  
//  UIViewController+Ext.swift
//  Wordy Word (UIKit)
//
//  Created with ❤️‍🔥 by Michael Caesario on 12/12/23.
//  Copyright © 2023 Michael Caesario. All rights reserved.
// 
//  Website: https://mikecaesario.app
//  GitHub: https://github.com/mikecaesario
//  LinkedIn: https://www.linkedin.com/in/mikecaesario/
//

import UIKit

extension UIViewController {
    
    func setupAndConfigureToastToView(toast: Toast, withType: ToastTypeEnum, onCompletion: @escaping (Bool) -> ()) {
        
        toast.configureToast(withType: withType)
        
        toast.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(toast)
        
        NSLayoutConstraint.activate([
            
            toast.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            toast.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16),
            toast.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -26),
            toast.heightAnchor.constraint(greaterThanOrEqualTo: self.view.heightAnchor, multiplier: 0.12)
        ])
        
        // Move the toast outside of the visible area initially
        toast.transform = CGAffineTransform(translationX: 0, y: 200)
        
        UIView.animate(withDuration: 1.0, delay: 0, options: .curveEaseInOut, animations: {
            // Slide up
            toast.transform = .identity
        }) { _ in
            // Wait for a while and then slide down
            UIView.animate(withDuration: 1.0, delay: 2.0, options: .curveEaseInOut, animations: {
                
                toast.transform = CGAffineTransform(translationX: 0, y: 200)
            }) { _ in
                // Remove from superview
                toast.removeFromSuperview()
                onCompletion(true)
            }
        }
    }
}
