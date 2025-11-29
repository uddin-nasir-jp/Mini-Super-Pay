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
        return balance >= amount
    }
}

// MARK: - Mock Wallet value
extension Wallet {
    static let mockWallet = Wallet(balance: 100.00)
    
    static let mockWalletLowBalance = Wallet(balance: 5.00)
    
    static let mockWalletHighBalance = Wallet(balance: 1000.00)
}
