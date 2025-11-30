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
    @Environment(ToastManager.self) private var toastManager
    
    var body: some View {
        VStack {
            if cartViewModel.isEmpty {
                SPEmptyStateView(
                    icon: "cart",
                    title: .cartEmptyTitle,
                    message: .cartEmptyMessage,
                    actionTitle: .cartEmptyAction,
                    action: {
                        appNavigator.navigateToBack()
                    }
                )
            } else {
                // Show cart data
                cartContentView
            }
        }
        .navigationTitle(String.cartMyCart)
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
                            handleRemoveItem(item.id)
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
                SPTextView(
                    text: .cartCheckout,
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
    
    // MARK: - Actions
    private func handleRemoveItem(_ itemId: String) {
        // Add haptic feedback
        let impact = UINotificationFeedbackGenerator()
        impact.notificationOccurred(.warning)
        
        withAnimation {
            cartViewModel.removeItem(itemId)
        }
        
        toastManager.show(.toastRemovedFromCart, type: .info)
    }
}

#Preview {
    NavigationStack {
        CartView()
            .environment(AppNavigator())
            .environment(CartViewModel())
    }
}
