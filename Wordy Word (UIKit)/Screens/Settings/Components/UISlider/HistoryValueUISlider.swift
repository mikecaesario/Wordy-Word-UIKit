//
//  HistoryValueUISlider.swift
//  Wordy Word (UIKit)
//
//  Created by Michael Caesario on 21/09/23.
//

import Foundation
import UIKit

class HistoryValueUISlider: UISlider {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureSlider()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func trackRect(forBounds bounds: CGRect) -> CGRect {
        var customTrackSize = super.trackRect(forBounds: bounds)
        customTrackSize.size.height = 12
        return customTrackSize
    }
    
    private func configureSlider() {
        minimumTrackTintColor = .background.quarternary
        thumbTintColor = .background.quarternary
        maximumTrackTintColor = .background.secondary
        isContinuous = true
    }
    
    func setupSlider(minValue: Float, maxValue: Float) {
        minimumValue = minValue
        maximumValue = maxValue
    }
}
