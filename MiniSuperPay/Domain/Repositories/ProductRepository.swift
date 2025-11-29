//
//  ProductRepository.swift
//  MiniSuperPay
//
//  Created by Nasir Uddin on 28/11/25.
//

import Foundation

// MARK: - Product Repository

final class ProductRepository: ProductRepositoryProtocol {
    static let shared = ProductRepository()
    
    private let networkService: NetworkServiceProtocol
    private var cachedProducts: [Product] = []
    
    init(networkService: NetworkServiceProtocol = NetworkService()) {
        self.networkService = networkService
    }
    
    /// Get product list
    func fetchProducts() async throws -> [Product] {
        let products = try await networkService.fetchProducts()
        cachedProducts = products
        return products
    }
    
    /// Get product by id (single product)
    func getProduct(by id: String) -> Product? {
        return cachedProducts.first { $0.id == id }
    }
}

// MARK: - Mock service used for unit tests and SwiftUI previews/views.

final class MockProductRepository: ProductRepositoryProtocol {
    var shouldFail = false
    var mockProducts: [Product] = Product.mockProducts
    
    func fetchProducts() async throws -> [Product] {
        if shouldFail {
            throw NetworkError.serverError
        }
        return mockProducts
    }
    
    func getProduct(by id: String) -> Product? {
        return mockProducts.first { $0.id == id }
    }
}
