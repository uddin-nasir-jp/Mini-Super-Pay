//
//  PreferenceKeys.swift
//  MiniSuperPay
//
//  Created by Nasir Uddin on 29/11/25.
//

import Foundation

// MARK: - Preference Keys for User Defaults
enum PreferenceKeys: String {
    case cart = "minisuperpay.cart"
    case wallet = "minisuperpay.wallet"
    
    static let defaultWalletBalance: Double = AppConstants.defaultWalletBalance
}
