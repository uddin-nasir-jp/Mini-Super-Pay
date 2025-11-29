//
//  CartStorageService.swift
//  MiniSuperPay
//
//  Created by Nasir Uddin on 29/11/25.
//

import Foundation

// MARK: - Cart Storage Service and Protocol

protocol CartStorageProtocol {
    func saveCart(_ items: [CartItem]) throws
    func loadCart() throws -> [CartItem]
    func clearCart() throws
    func cartExists() -> Bool
}

final class CartStorageService: CartStorageProtocol {
    static let shared = CartStorageService()
    
    private let userDefaults: UserDefaults
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    
    init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
    }
    
    /// Save Cart to storage
    func saveCart(_ items: [CartItem]) throws {
        do {
            let data = try encoder.encode(items)
            userDefaults.set(data, forKey: PreferenceKeys.cart.rawValue)
        } catch {
            print("❌ Failed to save cart: \(error.localizedDescription)")
            throw StorageError.encodingFailed
        }
    }
    
    /// Load previously added all carts
    func loadCart() throws -> [CartItem] {
        guard let data = userDefaults.data(forKey: PreferenceKeys.cart.rawValue) else {
            return []
        }
        
        do {
            let items = try decoder.decode([CartItem].self, from: data)
            return items
        } catch {
            print("❌ Failed to load cart: \(error.localizedDescription)")
            throw StorageError.decodingFailed
        }
    }
    
    /// Clear carts if exist
    func clearCart() throws {
        userDefaults.removeObject(forKey: PreferenceKeys.cart.rawValue)
    }
    
    func cartExists() -> Bool {
        return userDefaults.data(forKey: PreferenceKeys.cart.rawValue) != nil
    }
}

// MARK: - Mock service used for unit tests and SwiftUI previews/views.

final class MockCartStorageService: CartStorageProtocol {
    var shouldFail = false
    var mockCart: [CartItem] = []
    
    func saveCart(_ items: [CartItem]) throws {
        if shouldFail {
            throw StorageError.saveFailed
        }
        mockCart = items
    }
    
    func loadCart() throws -> [CartItem] {
        if shouldFail {
            throw StorageError.loadFailed
        }
        return mockCart
    }
    
    func clearCart() throws {
        if shouldFail {
            throw StorageError.saveFailed
        }
        mockCart = []
    }
    
    func cartExists() -> Bool {
        return !mockCart.isEmpty
    }
}
