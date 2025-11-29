//
//  ProductRepositoryProtocol.swift
//  MiniSuperPay
//
//  Created by Nasir Uddin on 28/11/25.
//

import Foundation

protocol ProductRepositoryProtocol {
    /// Fetches all available products from the data source
    func fetchProducts() async throws -> [Product]
    
    /// Fetches a specific product by ID from cached products
    /// Product if found, nil otherwise (Optional declaration)
    func getProduct(by id: String) -> Product?
}
