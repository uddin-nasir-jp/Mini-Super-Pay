//
//  CartRepository.swift
//  MiniSuperPay
//
//  Created by Nasir Uddin on 28/11/25.
//

import Foundation

// MARK: - Cart data repository
final class CartRepository: CartRepositoryProtocol {
    static let shared = CartRepository()
    
    private let cartStorage: CartStorageProtocol
    private var cartItems: [CartItem] = []
    
    init(cartStorage: CartStorageProtocol = CartStorageService.shared) {
        self.cartStorage = cartStorage
        self.cartItems = (try? cartStorage.loadCart()) ?? []
    }
    
    func loadCart() throws -> [CartItem] {
        cartItems = try cartStorage.loadCart()
        return cartItems
    }
    
    func addToCart(_ product: Product) throws -> [CartItem] {
        if let index = cartItems.firstIndex(where: { $0.product.id == product.id }) {
            let newQuantity = min(
                cartItems[index].quantity + 1,
                AppConstants.maximumCartQuantity
            )
            cartItems[index].quantity = newQuantity
        } else {
            let newItem = CartItem(
                id: UUID().uuidString,
                product: product,
                quantity: 1
            )
            cartItems.append(newItem)
        }
        
        try cartStorage.saveCart(cartItems)
        
        return cartItems
    }
    
    func updateQuantity(for itemId: String, quantity: Int) throws -> [CartItem] {
        guard let index = cartItems.firstIndex(where: { $0.id == itemId }) else {
            return cartItems
        }
        
        let validatedQuantity = max(
            AppConstants.minimumCartQuantity,
            min(quantity, AppConstants.maximumCartQuantity)
        )
        
        cartItems[index].quantity = validatedQuantity
        
        try cartStorage.saveCart(cartItems)
        
        return cartItems
    }
    
    func removeFromCart(_ itemId: String) throws -> [CartItem] {
        cartItems.removeAll { $0.id == itemId }
        
        try cartStorage.saveCart(cartItems)
        
        return cartItems
    }
    
    func clearCart() throws {
        cartItems = []
        try cartStorage.clearCart()
    }
    
    func getTotalCartPrice() -> Double {
        return cartItems.reduce(0) { $0 + $1.totalPrice } 
    }
}

// MARK: - Mock service used for unit tests and SwiftUI previews/views.

final class MockCartRepository: CartRepositoryProtocol {
    var shouldFail = false
    var mockCartItems: [CartItem] = []
    
    func loadCart() throws -> [CartItem] {
        if shouldFail {
            throw StorageError.loadFailed
        }
        return mockCartItems
    }
    
    func addToCart(_ product: Product) throws -> [CartItem] {
        if shouldFail {
            throw StorageError.saveFailed
        }
        
        if let index = mockCartItems.firstIndex(where: { $0.product.id == product.id }) {
            mockCartItems[index].quantity += 1
        } else {
            let newItem = CartItem(id: UUID().uuidString, product: product, quantity: 1)
            mockCartItems.append(newItem)
        }
        
        return mockCartItems
    }
    
    func updateQuantity(for itemId: String, quantity: Int) throws -> [CartItem] {
        if shouldFail {
            throw StorageError.saveFailed
        }
        
        if let index = mockCartItems.firstIndex(where: { $0.id == itemId }) {
            mockCartItems[index].quantity = quantity
        }
        
        return mockCartItems
    }
    
    func removeFromCart(_ itemId: String) throws -> [CartItem] {
        if shouldFail {
            throw StorageError.saveFailed
        }
        
        mockCartItems.removeAll { $0.id == itemId }
        return mockCartItems
    }
    
    func clearCart() throws {
        if shouldFail {
            throw StorageError.saveFailed
        }
        mockCartItems = []
    }
    
    func getTotalCartPrice() -> Double {
        mockCartItems.reduce(0) { $0 + $1.totalPrice }
    }
}
