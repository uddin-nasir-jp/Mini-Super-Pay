//
//  Wallet.swift
//  MiniSuperPay
//
//  Created by Nasir Uddin on 29/11/25.
//

import Foundation

// MARK: - Wallet Data Model

struct Wallet: Codable, Equatable {
    // MARK: - Property
    var balance: Double
    
    // MARK: - Methods
    var formattedBalance: String {
        balance.asFormattedCurrency
    }
    
    mutating func deductBalance(_ amount: Double) -> Bool {
        guard balance >= amount else { return false }
        balance -= amount
        return true
    }
    
    mutating func addBalance(_ amount: Double) {
        balance += amount
    }
    
    func hasSufficientFunds(for amount: Double) -> Bool {
        balance >= amount
    }
}
