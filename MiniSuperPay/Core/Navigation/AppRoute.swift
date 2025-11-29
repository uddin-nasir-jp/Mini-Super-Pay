//
//  AppRoute.swift
//  MiniSuperPay
//
//  Created by Nasir Uddin on 28/11/25.
//

import Foundation

// MARK: - All navigation destinations in the app

enum AppRoute: Hashable, Identifiable {
    case productList
    case cart
    case checkout
    case productDetail(Product)
    
    var id: String {
        switch self {
        case .productList:
            return "productList"
        case .cart:
            return "cart"
        case .checkout:
            return "checkout"
        case .productDetail(let product):
            return "productDetail_\(product.id)"
        }
    }
}
