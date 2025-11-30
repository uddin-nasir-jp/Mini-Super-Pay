//
//  String+Localization.swift
//  MiniSuperPay
//
//  Created by Nasir Uddin on 30/11/25.
//

import Foundation

// MARK: - Localization Helper
extension String {
    /// Returns localized string from Localizable.strings
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
    
    /// Returns localized string with format arguments
    func localized(with arguments: CVarArg...) -> String {
        return String(format: self.localized, arguments: arguments)
    }
}

// MARK: - App Localized Strings
extension String {
    // MARK: - General
    static let appName = "app.name".localized
    static let ok = "ok".localized
    static let cancel = "cancel".localized
    static let done = "done".localized
    static let retry = "retry".localized
    
    // MARK: - Navigation
    static let navProducts = "nav.products".localized
    static let navCart = "nav.cart".localized
    static let navCheckout = "nav.checkout".localized
    static let navBack = "nav.back".localized
    
    // MARK: - Product
    static let productAddToCart = "product.add.to.cart".localized
    static let productAlreadyInCart = "product.already.in.cart".localized
    static let productAdded = "product.added".localized
    static let productAdd = "product.add".localized
    static let productPrice = "product.price".localized
    static let productDescription = "product.description".localized
    static let productCategory = "product.category".localized
    
    // MARK: - Product List
    static let productListTitle = "product.list.title".localized
    static let productListWelcomeTitle = "product.list.welcome.title".localized
    static let productListWelcomeMessage = "product.list.welcome.message".localized
    static let productListLoadAction = "product.list.load.action".localized
    static let productListLoadingMessage = "product.list.loading.message".localized
    
    // MARK: - Cart
    static let cartTitle = "cart.title".localized
    static let cartMyCart = "cart.my.cart".localized
    static let cartEmptyTitle = "cart.empty.title".localized
    static let cartEmptyMessage = "cart.empty.message".localized
    static let cartEmptyAction = "cart.empty.action".localized
    static let cartTotal = "cart.total".localized
    static let cartTotalPrice = "cart.total.price".localized
    static let cartItemsQty = "cart.items.qty".localized
    static let cartCheckout = "cart.checkout".localized
    static let cartContinueShopping = "cart.continue.shopping".localized
    
    // MARK: - Checkout
    static let checkoutTitle = "checkout.title".localized
    static let checkoutOrderSummary = "checkout.order.summary".localized
    static let checkoutCompletePurchase = "checkout.complete.purchase".localized
    static let checkoutProcessing = "checkout.processing".localized
    static let checkoutProcessingMessage = "checkout.processing.message".localized
    static let checkoutSuccess = "checkout.success".localized
    static let checkoutFailed = "checkout.failed".localized
    static let checkoutContinueShopping = "checkout.continue.shopping".localized
    static let checkoutTryAgain = "checkout.try.again".localized
    static let checkoutBackToCart = "checkout.back.to.cart".localized
    
    // MARK: - Wallet
    static let walletBalance = "wallet.balance".localized
    static let walletAvailable = "wallet.available".localized
    static let walletRequired = "wallet.required".localized
    static let walletInsufficientFunds = "wallet.insufficient.funds".localized
    static let walletInsufficientMessage = "wallet.insufficient.message".localized
    static let walletNewBalance = "wallet.new.balance".localized
    static let walletAmountPaid = "wallet.amount.paid".localized
    
    // MARK: - Toast
    static let toastAddedToCart = "toast.added.to.cart".localized
    static let toastRemovedFromCart = "toast.removed.from.cart".localized
    static let toastErrorGeneric = "toast.error.generic".localized
    static let toastErrorLoadProducts = "toast.error.load.products".localized
    static let toastErrorLoadCart = "toast.error.load.cart".localized
    static let toastErrorCheckout = "toast.error.checkout".localized
    
    // MARK: - Empty State
    static let emptyTitle = "empty.title".localized
    static let emptyMessage = "empty.message".localized
    static let emptyAction = "empty.action".localized
    
    // MARK: - Error State
    static let errorTitle = "error.title".localized
    static let errorOops = "error.oops".localized
    static let errorTryAgain = "error.try.again".localized
    static let errorGoBack = "error.go.back".localized
    
    // MARK: - Loading
    static let loadingMessage = "loading.message".localized
    
    // MARK: - Actions
    static let actionDelete = "action.delete".localized
    
    // MARK: - Dynamic Strings
    static func cartQuantity(_ count: Int) -> String {
        return "cart.quantity".localized(with: count)
    }
}
