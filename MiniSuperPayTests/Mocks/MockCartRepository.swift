//
//  MockCartRepository.swift
//  MiniSuperPayTests
//
//  Created by Nasir Uddin on 01/12/25.
//

import Foundation
@testable import MiniSuperPay

final class MockCartRepository: CartRepositoryProtocol {
    // MARK: - Properties
    private(set) var cartItems: [CartItem] = []
    var shouldThrowError = false
    var errorToThrow: Error = StorageError.saveFailed
    
    // MARK: - CartRepositoryProtocol
    func loadCart() throws -> [CartItem] {
        if shouldThrowError {
            throw errorToThrow
        }
        return cartItems
    }
    
    func addToCart(_ product: Product) throws -> [CartItem] {
        if shouldThrowError {
            throw errorToThrow
        }
        
        if let index = cartItems.firstIndex(where: { $0.product.id == product.id }) {
            cartItems[index].quantity += 1
        } else {
            let newItem = CartItem(id: UUID().uuidString, product: product, quantity: 1)
            cartItems.append(newItem)
        }
        return cartItems
    }
    
    func updateQuantity(for itemId: String, quantity: Int) throws -> [CartItem] {
        if shouldThrowError {
            throw errorToThrow
        }
        
        if let index = cartItems.firstIndex(where: { $0.id == itemId }) {
            cartItems[index].quantity = quantity
        }
        return cartItems
    }
    
    func removeFromCart(_ itemId: String) throws -> [CartItem] {
        if shouldThrowError {
            throw errorToThrow
        }
        
        cartItems.removeAll { $0.id == itemId }
        return cartItems
    }
    
    func clearCart() throws {
        if shouldThrowError {
            throw errorToThrow
        }
        cartItems.removeAll()
    }
    
    func getTotalCartPrice() -> Double {
        cartItems.reduce(0) { $0 + ($1.product.price * Double($1.quantity)) }
    }
}
