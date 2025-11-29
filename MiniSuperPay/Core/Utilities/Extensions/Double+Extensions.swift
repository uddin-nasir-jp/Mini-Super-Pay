//
//  Double+Extensions.swift
//  MiniSuperPay
//
//  Created by Nasir Uddin on 28/11/25.
//

import Foundation

extension Double {
    
    //MARK: - Format price value  to display
    var asFormattedCurrency: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "USD"
        return formatter.string(from: NSNumber(value: self)) ?? "$0.00"
    }
}
