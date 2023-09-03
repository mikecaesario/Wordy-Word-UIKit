//
//  DateFormatter+Ext.swift
//  Wordy Word (UIKit)
//
//  Created by Michael Caesario on 03/09/23.
//

import Foundation

extension DateFormatter {
    
    static let formattedHourFromDate: DateFormatter = {
        
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.timeStyle = .short
        
        return formatter
    }()
    
    static let formattedDateInFull: DateFormatter = {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, MMM d, yyyy"
        
        return formatter
    }()
}
