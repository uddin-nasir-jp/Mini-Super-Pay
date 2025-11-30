//
//  CheckoutView.swift
//  MiniSuperPay
//
//  Created by Nasir Uddin on 29/11/25.
//

import SwiftUI

// MARK: - Checkout View
struct CheckoutView: View {
    // MARK: - PROPERTIES
    @Environment(AppNavigator.self) private var appNavigator
    @Environment(CartViewModel.self) private var cartViewModel
    @State private var checkoutViewModel = CheckoutViewModel()
    
    var body: some View {
        VStack {
            switch checkoutViewModel.checkoutLoadingState {
            case .idle:
                checkoutContentView
                
            case .loading:
                ProcessingView()
                
            case .success:
                CheckoutSuccessView(
                    successMessage: checkoutViewModel.successMessage,
                    amountPaid: checkoutViewModel.formattedTotalCartPrice,
                    newBalance: checkoutViewModel.formattedWalletBalance,
                    onContinueShopping: {
                        appNavigator.navigateToRootView()
                    }
                )
                .onAppear {
                    cartViewModel.clearCart()
                }
                
            case .failure:
                CheckoutErrorView(
                    errorMessage: checkoutViewModel.errorMessage,
                    onRetry: {
                        Task {
                            await checkoutViewModel.retryCheckout()
                        }
                    },
                    onBackToCart: {
                        appNavigator.navigateToBack()
                    }
                )
            }
        }
        .navigationTitle(String.checkoutTitle)
        .navigationBarTitleDisplayMode(.large)
        .task {
            checkoutViewModel.loadWallet()
        }
    }
    
    private var checkoutContentView: some View {
        ScrollView {
            VStack(spacing: DesignConstants.largeSpacing) {
                if let wallet = checkoutViewModel.wallet {
                    WalletBalanceView(
                        wallet: wallet,
                        requiredAmount: checkoutViewModel.totalCartPrice
                    )
                    .padding(.horizontal)
                }
                
                OrderSummaryView(
                    items: checkoutViewModel.cartItems,
                    total: checkoutViewModel.totalCartPrice
                )
                .padding(.horizontal)
            }
            .padding(.vertical, DesignConstants.mediumSpacing)
        }
        .safeAreaInset(edge: .bottom) {
            CheckoutActionsView(
                canProceed: checkoutViewModel.canProceedCheckout,
                onCheckout: {
                    Task {
                        await checkoutViewModel.processCheckout()
                    }
                },
                onCancel: {
                    appNavigator.navigateToBack()
                }
            )
            .padding()
            .background(.ultraThinMaterial)
        }
    }
}

#Preview {
    NavigationStack {
        CheckoutView()
            .environment(AppNavigator())
            .environment(CartViewModel())
    }
}

