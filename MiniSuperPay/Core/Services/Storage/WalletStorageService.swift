//
//  WalletStorageService.swift
//  MiniSuperPay
//
//  Created by Nasir Uddin on 29/11/25.
//

import Foundation

// MARK: Wallet Storage Service and Protocol

protocol WalletStorageProtocol {
    func saveWallet(_ wallet: Wallet) throws
    func loadWallet() throws -> Wallet
    func clearWallet() throws
    func walletExists() -> Bool
}

final class WalletStorageService: WalletStorageProtocol {
    static let shared = WalletStorageService()
    
    private let userDefaults: UserDefaults
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    
    init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
    }
    
    /// Save updated wallet
    func saveWallet(_ wallet: Wallet) throws {
        do {
            let data = try encoder.encode(wallet)
            userDefaults.set(data, forKey: PreferenceKeys.wallet.rawValue)
        } catch {
            print("❌ Failed to save wallet: \(error.localizedDescription)")
            throw StorageError.encodingFailed
        }
    }
    
    /// Load latest wallet value
    func loadWallet() throws -> Wallet {
        guard let data = userDefaults.data(forKey: PreferenceKeys.wallet.rawValue) else {
            let defaultWallet = Wallet(balance: PreferenceKeys.defaultWalletBalance)
            try? saveWallet(defaultWallet)
            return defaultWallet
        }
        
        do {
            let wallet = try decoder.decode(Wallet.self, from: data)
            return wallet
        } catch {
            print("❌ Failed to load wallet: \(error.localizedDescription)")
            throw StorageError.decodingFailed
        }
    }
    
    /// Clear wallet
    func clearWallet() throws {
        userDefaults.removeObject(forKey: PreferenceKeys.wallet.rawValue)
    }
    
    /// Checks if wallet data exists in UserDefaults
    func walletExists() -> Bool {
        return userDefaults.data(forKey: PreferenceKeys.wallet.rawValue) != nil
    }
}

// MARK: - Mock service used for unit tests and SwiftUI previews/views.

final class MockWalletStorageService: WalletStorageProtocol {
    var shouldFail = false
    var mockWallet = Wallet(balance: PreferenceKeys.defaultWalletBalance)
    
    func saveWallet(_ wallet: Wallet) throws {
        if shouldFail {
            throw StorageError.saveFailed
        }
        mockWallet = wallet
    }
    
    func loadWallet() throws -> Wallet {
        if shouldFail {
            throw StorageError.loadFailed
        }
        return mockWallet
    }
    
    func clearWallet() throws {
        if shouldFail {
            throw StorageError.saveFailed
        }
        mockWallet = Wallet(balance: PreferenceKeys.defaultWalletBalance)
    }
    
    func walletExists() -> Bool {
        return true
    }
}
