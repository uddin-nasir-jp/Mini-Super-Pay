//
//  Product.swift
//  MiniSuperPay
//
//  Created by Nasir Uddin on 29/11/25.
//

import Foundation

// MARK: - Product Data Model
struct Product: Identifiable, Codable, Equatable, Hashable {
    let id: String
    let name: String
    let price: Double
    let description: String
    let imageURL: String?
    let category: String
    
    var formattedPrice: String {
        price.asFormattedCurrency
    }
}

// MARK: - Mock products data

extension Product {
    static let mockProduct = Product(
        id: "1",
        name: "Fresh Apples",
        price: 2.99,
        description: "Crisp red apples - 1 kg",
        imageURL: "apple",
        category: "Fruits"
    )
    
    static let mockProducts = [
        Product(
            id: "1",
            name: "Fresh Apples",
            price: 2.99,
            description: "Crisp red apples - 1 kg",
            imageURL: "apple",
            category: "Fruits"
        ),
        Product(
            id: "2",
            name: "Organic Bananas",
            price: 1.99,
            description: "Sweet organic bananas - bunch",
            imageURL: "banana",
            category: "Fruits"
        ),
        Product(
            id: "3",
            name: "Pure Milk",
            price: 3.49,
            description: "Fresh whole milk - 1 liter",
            imageURL: "milk",
            category: "Dairy"
        ),
        Product(
            id: "4",
            name: "White Bread",
            price: 2.49,
            description: "Whole wheat bread loaf",
            imageURL: "bread",
            category: "Bakery"
        ),
        Product(
            id: "5",
            name: "Country Eggs",
            price: 4.99,
            description: "Free range eggs - dozen",
            imageURL: "eggs",
            category: "Dairy"
        )
    ]
}
