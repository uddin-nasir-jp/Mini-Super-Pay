//
//  ProductDetailView.swift
//  MiniSuperPay
//
//  Created by Nasir Uddin on 29/11/25.
//

import SwiftUI

struct ProductDetailView: View {
    let product: Product
    
    @Environment(AppNavigator.self) private var appNavigator
    @Environment(CartViewModel.self) private var cartViewModel
    @State private var showSuccessMessage = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: DesignConstants.largeSpacing) {
                Image(systemName: "photo")
                    .font(.system(size: 120))
                    .foregroundStyle(Color.textColor)
                    .frame(height: 200)
                    .frame(maxWidth: .infinity)
                    .background(Color(.systemGray6))
                    .cornerRadius(DesignConstants.mediumRadius)
                
                VStack(alignment: .leading, spacing: DesignConstants.mediumSpacing) {
                    CustomTextView(
                        text: product.category,
                        size: DesignConstants.xsFont,
                        weight: .medium,
                        textColor: .textColor
                    )
                    .padding(.horizontal, DesignConstants.smallSpacing)
                    .padding(.vertical, DesignConstants.extraSmallSpacing)
                    .background(Color.textColor.opacity(0.1))
                    .cornerRadius(DesignConstants.smallRadius)
                    
                    CustomTextView(
                        text: product.name,
                        size: DesignConstants.doubleXlFont,
                        weight: .bold,
                        textColor: .textColor
                    )
                    
                    CustomTextView(
                        text: product.description,
                        size: DesignConstants.baseFont,
                        textColor: .textColor
                    )
                    
                    Divider()
                    
                    HStack {
                        CustomTextView(
                            text: "Price:",
                            size: DesignConstants.baseFont,
                            weight: .semibold,
                            textColor: .textColor
                        )
                        
                        Spacer()
                        
                        CustomTextView(
                            text: product.formattedPrice,
                            size: DesignConstants.xlFont,
                            weight: .bold,
                            textColor: .successColor
                        )
                    }
                }
                .padding(.horizontal)
                
                Spacer(minLength: 80)
            }
            .padding(.vertical, DesignConstants.mediumSpacing)
        }
        .navigationTitle(product.name)
        .navigationBarTitleDisplayMode(.inline)
        .safeAreaInset(edge: .bottom) {
            addToCartButton
                .padding()
                .background(.ultraThinMaterial)
        }
        .overlay {
            if showSuccessMessage {
                successMessageOverlay
            }
        }
    }
    
    private var addToCartButton: some View {
        Button {
            cartViewModel.addToCart(product)
            withAnimation {
                showSuccessMessage = true
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                withAnimation {
                    showSuccessMessage = false
                }
                appNavigator.navigateToBack()
            }
        } label: {
            HStack {
                Image(systemName: "cart.badge.plus")
                    .font(.system(size: DesignConstants.baseFont))
                CustomTextView(
                    text: "Add to Cart",
                    size: DesignConstants.baseFont,
                    weight: .bold,
                    textColor: .white
                )
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.themePrimary)
            .cornerRadius(DesignConstants.mediumRadius)
        }
    }
    
    private var successMessageOverlay: some View {
        VStack {
            HStack(spacing: DesignConstants.smallSpacing) {
                Image(systemName: "checkmark.circle.fill")
                    .font(.system(size: DesignConstants.smFont))
                    .foregroundStyle(Color.successColor)
                CustomTextView(
                    text: "Added to cart!",
                    size: DesignConstants.smFont,
                    weight: .bold,
                    textColor: .textColor
                )
            }
            .padding()
            .background(.ultraThinMaterial)
            .cornerRadius(DesignConstants.largeRadius)
            .shadow(radius: 10)
            
            Spacer()
        }
        .padding(.top, 100)
        .transition(.move(edge: .top).combined(with: .opacity))
    }
}

#Preview {
    NavigationStack {
        ProductDetailView(product: .mockProduct)
            .environment(AppNavigator())
    }
}
