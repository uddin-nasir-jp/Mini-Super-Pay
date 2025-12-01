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
    var simulatedDelay: UInt64 = 0
    var mockResponse: CheckoutResponse?
    
    // MARK: - Method Call Tracking
    private(set) var processCheckoutCallCount = 0
    private(set) var validateCheckoutCallCount = 0
    private(set) var lastProcessedItems: [CartItem]?
    private(set) var lastProcessedTotal: Double?
    
    // MARK: - CheckoutRepositoryProtocol
    func processCheckout(items: [CartItem], total: Double) async throws -> CheckoutResponse {
        processCheckoutCallCount += 1
        lastProcessedItems = items
        lastProcessedTotal = total
        
        if simulatedDelay > 0 {
            try await Task.sleep(nanoseconds: simulatedDelay)
        }
        
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
        validateCheckoutCallCount += 1
        
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
    
    // MARK: - Helper Methods
    func reset() {
        shouldThrowError = false
        simulatedDelay = 0
        mockResponse = nil
        processCheckoutCallCount = 0
        validateCheckoutCallCount = 0
        lastProcessedItems = nil
        lastProcessedTotal = nil
    }
}
