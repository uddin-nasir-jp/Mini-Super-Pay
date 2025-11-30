//
//  CartRepositoryProtocol.swift
//  MiniSuperPay
//
//  Created by Nasir Uddin on 29/11/25.
//

import Foundation

protocol CartRepositoryProtocol {
    /// Loads cart items from persistent storage and show StorageError if loading fails
    func loadCart() throws -> [CartItem]
    
    /// Adds a product to the cart or increments quantity if already exists
    func addToCart(_ product: Product) throws -> [CartItem]
    
    /// Updates the quantity of a cart item within allowed limits
    func updateQuantity(for itemId: String, quantity: Int) throws -> [CartItem]
    
    /// Removes a specific cart item
    func removeFromCart(_ itemId: String) throws -> [CartItem]
    
    /// Removes all items from the cart
    func clearCart() throws
    
    /// Calculates the total price of all items in the cart
    func getTotalCartPrice() -> Double
}
