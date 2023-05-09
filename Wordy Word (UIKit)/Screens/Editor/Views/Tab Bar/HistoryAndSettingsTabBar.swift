//
//  HistoryAndSettingsTabBar.swift
//  Wordy Word (UIKit)
//
//  Created by Michael Caesario on 08/05/23.
//

import UIKit

class HistoryAndSettingsTabBar: UIView {

 
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
        layoutUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView() {
        
        self.layer.cornerRadius = 45
        self.layer.masksToBounds = true
    }
    
    private func layoutUI() {
        
        
    }
}
