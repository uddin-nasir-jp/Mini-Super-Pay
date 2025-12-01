//
//  AppConstants.swift
//  MiniSuperPay
//
//  Created by Nasir Uddin on 28/11/25.
//

import Foundation

// MARK: - App constants
enum AppConstants {
    // MARK: - App Info
    static let appName = "Mini SuperPay"
    static let appVersion = "1.0.0"
    
    // MARK: - Wallet constants
    static let defaultWalletBalance: Double = 50.00
    static let minimumWalletBalance: Double = 0.00
    
    // MARK: - Cart constants
    static let maximumCartQuantity: Int = 99
    static let minimumCartQuantity: Int = 1
    
    // MARK: - Network constants
    static let requestTimeout: TimeInterval = 30.0
    static let minNetworkDelay: UInt64 = 1_000_000_000 // 1 second
    static let maxNetworkDelay: UInt64 = 3_000_000_000 // 3 seconds
    
    // MARK: - Animation constants
    static let defaultAnimationDuration: Double = 0.3
    static let fastAnimationDuration: Double = 0.2
    static let slowAnimationDuration: Double = 0.5
}
