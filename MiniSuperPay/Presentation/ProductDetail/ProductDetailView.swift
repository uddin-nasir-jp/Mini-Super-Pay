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
                ProductImageView(imageName: "photo")
                    .padding(.horizontal)
                
                VStack(alignment: .leading, spacing: DesignConstants.largeSpacing) {
                    HStack {
                        ProductCategoryBadge(category: product.category)
                        Spacer()
                    }
                    
                    ProductInfoSection(
                        name: product.name,
                        description: product.description
                    )
                    
                    ProductPriceCard(price: product.formattedPrice)
                    
                    Spacer(minLength: 100)
                }
                .padding(.horizontal)
            }
            .padding(.vertical, DesignConstants.mediumSpacing)
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
        toastManager.show("Added to cart!", type: .success)
        
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
