//
//  ProductListViewModel.swift
//  MiniSuperPay
//
//  Created by Nasir Uddin on 29/11/25.
//

import Foundation

@Observable
final class ProductListViewModel {
    // MARK: - Properties
    
    var productLoadingState: AsyncLoadingState<[Product]> = .idle
    private let productRepository: ProductRepositoryProtocol
    
    // MARK: - Computed Properties
    /// Get products array from loadState
    var products: [Product] {
        productLoadingState.data ?? []
    }

    var isLoading: Bool {
        productLoadingState.isLoading
    }

    var errorMessage: String? {
        productLoadingState.error?.localizedDescription
    }
    
    // MARK: - Initialization
    init(productRepository: ProductRepositoryProtocol = ProductRepository.shared) {
        self.productRepository = productRepository
    }
    
    // MARK: - Public Methods
    /// Loads products from repository
    @MainActor
    func loadProducts() async {
        productLoadingState = .loading
        do {
            let products = try await productRepository.fetchProducts()
            productLoadingState = .success(products)
        } catch {
            productLoadingState = .failure(error)
        }
    }
    
    /// Retries loading products after failure
    @MainActor
    func retryLoading() async {
        await loadProducts()
    }
    
    // TODO: Implement products pagination functions
}
