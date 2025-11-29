//
//  NetworkService.swift
//  MiniSuperPay
//
//  Created by Nasir Uddin on 28/11/25.
//

import Foundation

// MARK: - Network Service Protocol

protocol NetworkServiceProtocol {
    func fetchProducts() async throws -> [Product]
    func processCheckout(items: [CartItem], total: Double) async throws -> CheckoutResponse
}

// MARK: - Network Service

final class NetworkService: NetworkServiceProtocol {
    func fetchProducts() async throws -> [Product] {
        // Set 1 second network delay
        try await Task.sleep(nanoseconds: 1_000_000_000)
        
        // Find url for products json data
        guard let url = Bundle.main.url(forResource: "products", withExtension: "json") else {
            throw NetworkError.fileNotFound
        }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let products = try decoder.decode([Product].self, from: data)
            return products
        } catch let error as DecodingError {
            print("Decoding error: \(error)")
            throw NetworkError.decodingError
        } catch {
            print("Error loading products: \(error)")
            throw NetworkError.invalidData
        }
    }
    
    /// Method for Checkout operation
    func processCheckout(items: [CartItem], total: Double) async throws -> CheckoutResponse {
        // Generate a random artificial network delay between 1–3 seconds
        let delay = UInt64.random(in: 1...3) * 1_000_000_000
        try await Task.sleep(nanoseconds: delay)
        
        // 75% chance of success (1 out of 4 values triggers failure)
        let shouldSucceed = Int.random(in: 1...4) != 1
        
        if !shouldSucceed {
            throw NetworkError.checkoutFailed
        }
        
        return CheckoutResponse(
            success: true,
            transactionId: "TXN-\(UUID().uuidString.prefix(8).uppercased())",
            message: "Payment processed successfully",
            timestamp: Date()
        )
    }
}

// MARK: - Mock service used for unit tests and SwiftUI previews/views.

final class MockNetworkService: NetworkServiceProtocol {
    var shouldFail = false
    var mockProducts: [Product] = Product.mockProducts
    var mockCheckoutResponse: CheckoutResponse = .mockSuccess
    
    func fetchProducts() async throws -> [Product] {
        if shouldFail {
            throw NetworkError.serverError
        }
        return mockProducts
    }
    
    func processCheckout(items: [CartItem], total: Double) async throws -> CheckoutResponse {
        if shouldFail {
            throw NetworkError.checkoutFailed
        }
        return mockCheckoutResponse
    }
}
