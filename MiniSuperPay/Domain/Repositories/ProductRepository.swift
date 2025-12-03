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
    
    init(networkService: NetworkServiceProtocol = NetworkServiceManager()) {
        self.networkService = networkService
    }
    
    /// Get product list from  API
    func fetchProducts() async throws -> [Product] {
        let endpoint = ProductsEndpoint.create()
        let products = try await networkService.performRequestAsync(endpoint, responseType: [Product].self)
        cachedProducts = products
        return products
    }
    
    /// Get product by id (single product)
    func getProduct(by id: String) -> Product? {
        return cachedProducts.first { $0.id == id }
    }
}
