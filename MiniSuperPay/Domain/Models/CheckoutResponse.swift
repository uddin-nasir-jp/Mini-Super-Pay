//
//  CheckoutResponse.swift
//  MiniSuperPay
//
//  Created by Nasir Uddin on 29/11/25.
//

import Foundation

// MARK: - Response from checkout API
struct CheckoutResponse: Codable, Equatable {
    let success: Bool
    let transactionId: String?
    let message: String
    let timestamp: Date
}

// MARK: - Mock Checkout response Data

extension CheckoutResponse {
    static let mockSuccess = CheckoutResponse(
        success: true,
        transactionId: "TXN-\(UUID().uuidString.prefix(8))",
        message: "Payment processed successfully",
        timestamp: Date()
    )
    
    static let mockFailure = CheckoutResponse(
        success: false,
        transactionId: nil,
        message: "Payment failed. Please try again.",
        timestamp: Date()
    )
}
