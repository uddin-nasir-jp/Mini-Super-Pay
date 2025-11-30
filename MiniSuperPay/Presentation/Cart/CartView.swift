//
//  CartView.swift
//  MiniSuperPay
//
//  Created by Nasir Uddin on 29/11/25.
//

import SwiftUI

// MARK: Cart View
struct CartView: View {
    // MARK: - PROPERTIES
    @Environment(AppNavigator.self) private var appNavigator
    @Environment(CartViewModel.self) private var cartViewModel
    
    var body: some View {
        Group {
            if cartViewModel.isEmpty {
                EmptyStateView(
                    icon: "cart",
                    title: "Your Cart is Empty",
                    message: "Add some delicious items to your cart",
                    actionTitle: "Continue Shopping",
                    action: {
                        appNavigator.navigateToBack()
                    }
                )
            } else {
                // Show cart data
                cartContentView
            }
        }
        .navigationTitle("My Cart")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private var cartContentView: some View {
        VStack(spacing: 0) {
            List {
                ForEach(cartViewModel.cartItems) { item in
                    CartItemView(
                        cartItem: item,
                        onIncrement: {
                            cartViewModel.increaseQuantity(for: item.id)
                        },
                        onDecrement: {
                            cartViewModel.decreaseQuantity(for: item.id)
                        },
                        onRemove: {
                            withAnimation {
                                cartViewModel.removeItem(item.id)
                            }
                        }
                    )
                }
            }
            .listStyle(.plain)
            
            VStack(spacing: DesignConstants.mediumSpacing) {
                CartSummaryView(
                    itemCount: cartViewModel.cartCount,
                    totalPrice: cartViewModel.totalPrice
                )
                
                checkoutButton
            }
            .padding(.vertical, DesignConstants.mediumSpacing)
            .padding(.horizontal)
            .background(.ultraThinMaterial)
        }
    }
    
    private var checkoutButton: some View {
        Button {
            appNavigator.navigateTo(.checkout)
        } label: {
            HStack {
                CustomTextView(
                    text: "Proceed to Checkout",
                    size: DesignConstants.baseFont,
                    weight: .bold,
                    textColor: .white
                )
                Image(systemName: "arrow.right")
                    .font(.system(size: DesignConstants.baseFont))
                    .foregroundStyle(.white)
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.blue)
            .cornerRadius(DesignConstants.mediumRadius)
        }
    }
}

#Preview {
    NavigationStack {
        CartView()
            .environment(AppNavigator())
            .environment(CartViewModel())
    }
}
