//
//  AppConstants.swift
//  MiniSuperPay
//
//  Created by Nasir Uddin on 28/11/25.
//

import Foundation

// MARK: - App constants
enum AppConstants {
    // MARK: - Wallet constants
    static let defaultWalletBalance: Double = 50.00
    static let minimumWalletBalance: Double = 0.00
    
    // MARK: - Cart constants
    static let maximumCartQuantity: Int = 99
    static let minimumCartQuantity: Int = 1
    
    // MARK: - Network constants
    static let minNetworkDelay: UInt64 = 1 // 1 second
    static let maxNetworkDelay: UInt64 = 3 // 3 seconds
    static let nanosecondMultiplier: UInt64 = 1_000_000_000
    
    // Helper to get random delay
    static var randomNetworkDelay: UInt64 {
        UInt64.random(in: minNetworkDelay...maxNetworkDelay) * nanosecondMultiplier
    }
}
