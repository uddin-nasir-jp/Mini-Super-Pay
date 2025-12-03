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
    
    enum CodingKeys: String, CodingKey {
        case checkoutResult = "checkout_result" // api response key
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        // Map checkoutresult from API to success
        let checkoutResult = try container.decode(Bool.self, forKey: .checkoutResult)
        self.success = checkoutResult
        
        // Generate transaction details based on result
        if checkoutResult {
            self.transactionId = "TXN-\(UUID().uuidString.prefix(8).uppercased())"
            self.message = "Payment processed successfully"
        } else {
            self.transactionId = nil
            self.message = "Payment failed. Please try again."
        }
        self.timestamp = Date()
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(success, forKey: .checkoutResult)
    }
    
    init(success: Bool, transactionId: String?, message: String, timestamp: Date) {
        self.success = success
        self.transactionId = transactionId
        self.message = message
        self.timestamp = timestamp
    }
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
