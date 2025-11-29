//
//  CartItem.swift
//  MiniSuperPay
//
//  Created by Nasir Uddin on 29/11/25.
//

import Foundation

// MARK: - Cart Data Model
struct CartItem: Identifiable, Codable, Equatable {
    let id: String
    let product: Product
    var quantity: Int
    
    var totalPrice: Double {
        product.price * Double(quantity)
    }
    
    var formattedTotalPrice: String {
        totalPrice.asFormattedCurrency
    }
}

// MARK: - Cart Mock Data

extension CartItem {
    static let mockCartItem = CartItem(
        id: UUID().uuidString,
        product: .mockProduct,
        quantity: 2
    )
    
    static let mockCartItems = [
        CartItem(
            id: UUID().uuidString,
            product: Product.mockProducts[0],
            quantity: 2
        ),
        CartItem(
            id: UUID().uuidString,
            product: Product.mockProducts[1],
            quantity: 1
        ),
        CartItem(
            id: UUID().uuidString,
            product: Product.mockProducts[2],
            quantity: 3
        )
    ]
}
