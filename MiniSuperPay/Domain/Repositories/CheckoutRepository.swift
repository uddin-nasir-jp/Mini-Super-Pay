//
//  CheckoutRepository.swift
//  MiniSuperPay
//
//  Created by Nasir Uddin on 28/11/25.
//

import Foundation

// MARK: - Checkout Error

enum CheckoutError: LocalizedError {
    case insufficientFunds
    case emptyCart
    case processingFailed
    
    var errorDescription: String? {
        switch self {
        case .insufficientFunds:
            return "Insufficient wallet balance. Please add funds."
        case .emptyCart:
            return "Your cart is empty. Add items before checkout."
        case .processingFailed:
            return "Payment processing failed. Please try again."
        }
    }
}

// MARK: - Checkout Repository

final class CheckoutRepository: CheckoutRepositoryProtocol {
    static let shared: CheckoutRepository = {
        CheckoutRepository(cartRepository: CartRepository.shared)
    }()
    
    private let networkService: NetworkServiceProtocol
    private let walletStorage: WalletStorageProtocol
    private let cartRepository: CartRepositoryProtocol
    
    init(
        networkService: NetworkServiceProtocol = NetworkService(),
        walletStorage: WalletStorageProtocol = WalletStorageService.shared,
        cartRepository: CartRepositoryProtocol
    ) {
        self.networkService = networkService
        self.walletStorage = walletStorage
        self.cartRepository = cartRepository
    }
    
    func validateCheckout(items: [CartItem], walletBalance: Double) throws {
        guard !items.isEmpty else {
            throw CheckoutError.emptyCart
        }
        
        let total = items.reduce(0) { $0 + $1.totalPrice }
        
        guard walletBalance >= total else {
            throw CheckoutError.insufficientFunds
        }
    }
    
    func processCheckout(items: [CartItem], total: Double) async throws -> CheckoutResponse {
        guard !items.isEmpty else {
            throw CheckoutError.emptyCart
        }
        
        var wallet = try walletStorage.loadWallet()
        
        guard wallet.balance >= total else {
            throw CheckoutError.insufficientFunds
        }
        
        let response = try await networkService.processCheckout(items: items, total: total)
        
        if response.success {
            guard wallet.deductBalance(total) else {
                throw CheckoutError.insufficientFunds
            }
            try walletStorage.saveWallet(wallet)
            
            //try cartRepository.clearCart()
        }
        
        return response
    }
}

// MARK: - Mock service used for unit tests and SwiftUI previews/views.

final class MockCheckoutRepository: CheckoutRepositoryProtocol {
    var shouldFail = false
    var mockResponse = CheckoutResponse.mockSuccess
    var mockWalletBalance: Double = 100.00
    
    func validateCheckout(items: [CartItem], walletBalance: Double) throws {
        if shouldFail {
            throw CheckoutError.insufficientFunds
        }
        
        guard !items.isEmpty else {
            throw CheckoutError.emptyCart
        }
        
        let total = items.reduce(0) { $0 + $1.totalPrice }
        guard walletBalance >= total else {
            throw CheckoutError.insufficientFunds
        }
    }
    
    func processCheckout(items: [CartItem], total: Double) async throws -> CheckoutResponse {
        if shouldFail {
            throw NetworkError.checkoutFailed
        }
        
        return mockResponse
    }
}
