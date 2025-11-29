//
//  Date+Extensions.swift
//  MiniSuperPay
//
//  Created by Nasir Uddin on 29/11/25.
//

import Foundation

extension Date {
    // PLAN: For further usages helper date formatter
    /// Format as medium date with short time
    var asFormattedDateTime: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: self)
    }
    
    /// Format as medium date only
    var asFormattedDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter.string(from: self)
    }
    
    /// Format as short time only
    var asFormattedTime: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.timeStyle = .short
        return formatter.string(from: self)
    }
}
