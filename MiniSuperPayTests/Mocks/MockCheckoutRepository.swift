//
//  MockCheckoutRepository.swift
//  MiniSuperPayTests
//
//  Created by Nasir Uddin on 01/12/25.
//

import Foundation
@testable import MiniSuperPay

final class MockCheckoutRepository: CheckoutRepositoryProtocol {
    // MARK: - Properties
    var shouldThrowError = false
    var errorToThrow: Error = CheckoutError.insufficientFunds
    var mockResponse: CheckoutResponse?
    
    // MARK: - CheckoutRepositoryProtocol
    func processCheckout(items: [CartItem], total: Double) async throws -> CheckoutResponse {
        if shouldThrowError {
            throw errorToThrow
        }
        
        if let response = mockResponse {
            return response
        }
        
        // Default success response
        return CheckoutResponse(
            success: true,
            transactionId: UUID().uuidString,
            message: "Payment successful!",
            timestamp: Date()
        )
    }
    
    func validateCheckout(items: [CartItem], walletBalance: Double) throws {
        if shouldThrowError {
            throw errorToThrow
        }
        
        guard !items.isEmpty else {
            throw CheckoutError.emptyCart
        }
        
        let total = items.reduce(0) { $0 + ($1.product.price * Double($1.quantity)) }
        guard walletBalance >= total else {
            throw CheckoutError.insufficientFunds
        }
    }
}
