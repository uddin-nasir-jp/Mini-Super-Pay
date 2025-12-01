//
//  ProductDetailView.swift
//  MiniSuperPay
//
//  Created by Nasir Uddin on 29/11/25.
//

import SwiftUI

// MARK: - Product details view
struct ProductDetailView: View {
    // MARK: - PROPERTIES
    @Environment(AppNavigator.self) private var appNavigator
    @Environment(CartViewModel.self) private var cartViewModel
    @Environment(ToastManager.self) private var toastManager
    let product: Product
    
    var body: some View {
        ScrollView {
            VStack(spacing: DesignConstants.largeSpacing) {
                /// Product image
                ProductImageView(imageURL: product.imageURL ?? "")
                
                VStack(alignment: .leading, spacing: DesignConstants.largeSpacing) {
                    /// Product category
                    ProductCategoryBadge(category: product.category)
                    
                    /// Product Info
                    ProductInfoSection(
                        name: product.name,
                        description: product.description
                    )
                    
                    // Price card
                    ProductPriceCard(price: product.formattedPrice)
                }
            }
            .padding(DesignConstants.mediumSpacing)
        }
        .safeAreaInset(edge: .bottom) {
            AddToCartButton(
                isInCart: cartViewModel.cartItems.contains { $0.product.id == product.id },
                onAddToCart: handleAddToCart
            )
            .padding()
            .background(.ultraThinMaterial)
        }
        .navigationTitle(product.name)
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func handleAddToCart() {
        cartViewModel.addToCart(product)
        toastManager.show(.toastAddedToCart, type: .success)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            appNavigator.navigateToBack()
        }
    }
}

#Preview {
    NavigationStack {
        ProductDetailView(product: .mockProduct)
            .environment(AppNavigator())
            .environment(CartViewModel())
            .environment(ToastManager())
    }
}
