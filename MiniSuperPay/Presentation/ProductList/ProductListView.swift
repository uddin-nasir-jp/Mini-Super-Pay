//
//  ProductListView.swift
//  MiniSuperPay
//
//  Created by Nasir Uddin on 29/11/25.
//

import SwiftUI

struct ProductListView: View {
    @Environment(AppNavigator.self) private var appNavigator
    @Environment(CartViewModel.self) private var cartViewModel
    @State private var productListViewModel = ProductListViewModel()
    
    var body: some View {
        Group {
            switch productListViewModel.productLoadingState {
            case .idle:
                EmptyStateView(
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
                LoadingView(message: "Loading products...")
                
            case .success:
                productsList
                
            case .failure(let error):
                ErrorView(error: error) {
                    await productListViewModel.retryLoading()
                }
            }
        }
        .navigationTitle("Products")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                cartButton
            }
        }
        .task {
            if case .idle = productListViewModel.productLoadingState {
                await productListViewModel.loadProducts()
            }
        }
    }
    
    private var productsList: some View {
        List {
            ForEach(productListViewModel.products) { product in
                ProductListItemView(
                    product: product,
                    isInCart: cartViewModel.cartItems.contains { $0.product.id == product.id },
                    onAddToCart: {
                        cartViewModel.addToCart(product)
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
    
    private var cartButton: some View {
        Button {
            appNavigator.navigateTo(.cart)
        } label: {
            ZStack(alignment: .topTrailing) {
                Image(systemName: "cart.fill")
                    .font(.title3)
                
                if cartViewModel.cartCount > 0 {
                    CustomTextView(
                        text: "\(cartViewModel.cartCount)",
                        size: DesignConstants.doubleXSFont,
                        weight: .bold,
                        textColor: .white
                    )
                    .frame(minWidth: 16, minHeight: 16)
                    .background(Color.errorColor)
                    .clipShape(Circle())
                    .offset(x: 10, y: -10)
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        ProductListView()
            .environment(AppNavigator())
    }
}
