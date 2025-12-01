//
//  Product+TestHelpers.swift
//  MiniSuperPayTests
//
//  Created by Nasir Uddin on 01/12/25.
//

import Foundation
@testable import MiniSuperPay

extension Product {
    static var testProduct1: Product {
        Product(
            id: "test-1",
            name: "Test Product 1",
            price: 10.0,
            description: "Test description 1",
            imageURL: nil,
            category: "Electronics"
        )
    }
    
    static var testProduct2: Product {
        Product(
            id: "test-2",
            name: "Test Product 2",
            price: 20.0,
            description: "Test description 2",
            imageURL: nil,
            category: "Books"
        )
    }
    
    static var testProduct3: Product {
        Product(
            id: "test-3",
            name: "Test Product 3",
            price: 15.0,
            description: "Test description 3",
            imageURL: nil,
            category: "Clothing"
        )
    }
}

extension CartItem {
    static var testCartItem1: CartItem {
        CartItem(
            id: "cart-test-1",
            product: .testProduct1,
            quantity: 1
        )
    }
    
    static var testCartItem2: CartItem {
        CartItem(
            id: "cart-test-2",
            product: .testProduct2,
            quantity: 2
        )
    }
    
    static var testCartItem3: CartItem {
        CartItem(
            id: "cart-test-3",
            product: .testProduct3,
            quantity: 3
        )
    }
}

extension Wallet {
    static var testWalletWithSufficientFunds: Wallet {
        Wallet(balance: 1000.0)
    }
    
    static var testWalletWithInsufficientFunds: Wallet {
        Wallet(balance: 10.0)
    }
}

extension CheckoutResponse {
    static var testSuccessResponse: CheckoutResponse {
        CheckoutResponse(
            success: true,
            transactionId: "test-transaction-123",
            message: "Payment successful!",
            timestamp: Date()
        )
    }
    
    static var testFailureResponse: CheckoutResponse {
        CheckoutResponse(
            success: false,
            transactionId: nil,
            message: "Insufficient funds",
            timestamp: Date()
        )
    }
}
