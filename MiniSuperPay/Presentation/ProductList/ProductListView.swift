//
//  ProductListView.swift
//  MiniSuperPay
//
//  Created by Nasir Uddin on 29/11/25.
//

import SwiftUI

// MARK: - Product List View
struct ProductListView: View {
    // MARK: - PROPERTIES
    @Environment(AppNavigator.self) private var appNavigator
    @Environment(CartViewModel.self) private var cartViewModel
    @Environment(ToastManager.self) private var toastManager
    @State private var productListViewModel = ProductListViewModel()
    
    var body: some View {
        VStack {
            switch productListViewModel.productLoadingState {
            case .idle:
                SPEmptyStateView(
                    icon: "cart",
                    title: "Welcome to SuperPay",
                    message: "Tap below to load products",
                    actionTitle: "Load Products",
                    action: {
                        Task {
                            await productListViewModel.loadProducts()
                        }
                    }
                )
                
            case .loading:
                SPLoadingView(message: "Loading products...")
                
            case .success:
                productsList
                
            case .failure(let error):
                SPErrorView(error: error) {
                    await productListViewModel.retryLoading()
                }
            }
        }
        .navigationTitle("Products")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                cartButtonView
            }
        }
        .task {
            if case .idle = productListViewModel.productLoadingState {
                await productListViewModel.loadProducts()
            }
        }
    }
    
    // MARK: - Product list content view
    private var productsList: some View {
        List {
            ForEach(productListViewModel.products) { product in
                ProductListItemView(
                    product: product,
                    isInCart: cartViewModel.cartItems.contains { $0.product.id == product.id },
                    onAddToCart: {
                        handleAddToCart(product)
                    }
                )
                .contentShape(Rectangle())
                .onTapGesture {
                    appNavigator.navigateTo(.productDetail(product))
                }
            }
        }
        .listStyle(.plain)
        .refreshable {
            await productListViewModel.loadProducts()
        }
    }
    
    // MARK: - Cart button
    private var cartButtonView: some View {
        Button {
            appNavigator.navigateTo(.cart)
        } label: {
            ZStack(alignment: .topTrailing) {
                Image(systemName: "cart.fill")
                    .font(.system(size: DesignConstants.smallIcon))
                    .padding(.trailing, 4)
                    .padding(.top, 4)
                
                if cartViewModel.cartCount > 0 {
                    SPTextView(
                        text: "\(cartViewModel.cartCount)",
                        size: DesignConstants.doubleXSFont,
                        weight: .bold,
                        textColor: .white
                    )
                    .padding(4)
                    .background(Color.errorColor)
                    .clipShape(Circle())
                    .offset(x: 6, y: -6)
                }
            }
        }
    }
    
    // MARK: - Actions
    private func handleAddToCart(_ product: Product) {
        cartViewModel.addToCart(product)
        toastManager.show("Added to cart!", type: .success)
    }
}

#Preview {
    NavigationStack {
        ProductListView()
            .environment(AppNavigator())
            .environment(CartViewModel())
    }
}
