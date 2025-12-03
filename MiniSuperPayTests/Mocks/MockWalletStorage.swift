//
//  MockWalletStorage.swift
//  MiniSuperPayTests
//
//  Created by Nasir Uddin on 03/12/25.
//

import Foundation
@testable import MiniSuperPay

final class MockWalletStorage: WalletStorageProtocol {
    var mockWallet: Wallet = Wallet.testWalletWithSufficientFunds
    var shouldThrowError = false
    var errorToThrow: Error = StorageError.loadFailed
    var walletExistsValue = true
    
    func loadWallet() throws -> Wallet {
        if shouldThrowError {
            throw errorToThrow
        }
        return mockWallet
    }
    
    func saveWallet(_ wallet: Wallet) throws {
        if shouldThrowError {
            throw errorToThrow
        }
        mockWallet = wallet
    }
    
    func clearWallet() throws {
        if shouldThrowError {
            throw errorToThrow
        }
        mockWallet = Wallet.testWalletEmpty
    }
    
    func walletExists() -> Bool {
        return walletExistsValue
    }
}
