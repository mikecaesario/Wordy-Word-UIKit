//
//  Date+Ext.swift
//  Wordy Word (UIKit)
//
//  Created by Michael Caesario on 16/05/23.
//

import Foundation

extension Date {
    
    func isSameDayAs(otherDate: Date) -> Bool {
        
        let calendar = Calendar.current
        
        let date1 = calendar.dateComponents([.day, .month, .year], from: self)
        let date2 = calendar.dateComponents([.day, .month, .year], from: otherDate)
        
        return date1 == date2
    }
    
    
}
