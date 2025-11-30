//
//  AppNavigatorView.swift
//  MiniSuperPay
//
//  Created by Nasir Uddin on 29/11/25.
//

import SwiftUI

struct AppNavigatorView: View {
    // MARK: - PROPERTIES
    @State private var appNavigator = AppNavigator()
    @State private var cartViewModel = CartViewModel()
    @State private var toastManager = ToastManager()
    
    var body: some View {
        ZStack {
            NavigationStack(path: $appNavigator.navPath) {
                destination(for: .productList)
                    .navigationDestination(for: AppRoute.self) { route in
                        destination(for: route)
                    }
                    .sheet(item: $appNavigator.presentedSheet) { route in
                        destination(for: route)
                    }
                    .fullScreenCover(item: $appNavigator.presentedFullScreenCover) { route in
                        destination(for: route)
                    }
            }
            .environment(appNavigator)
            .environment(cartViewModel)
            .environment(toastManager)
            
            if toastManager.showToast {
                SPToastView(
                    message: toastManager.toastMessage,
                    type: toastManager.toastType
                )
            }
        }
    }
    
    // MARK: - Navigation Destinations
    @ViewBuilder
    private func destination(for route: AppRoute) -> some View {
        switch route {
        case .productList:
            ProductListView()
            
        case .cart:
            CartView()
            
        case .checkout:
            CheckoutView()
            
        case .productDetail(let product):
            ProductDetailView(product: product)
        }
    }
}

#Preview {
    AppNavigatorView()
}
