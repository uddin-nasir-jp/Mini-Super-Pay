//
//  CheckoutViewModel.swift
//  MiniSuperPay
//
//  Created by Nasir Uddin on 29/11/25.
//

import Foundation

@Observable
final class CheckoutViewModel {
    // MARK: - Properties
    var checkoutLoadingState: AsyncLoadingState<CheckoutResponse> = .idle
    var walletLoadingState: AsyncLoadingState<Wallet> = .idle
    
    // MARK: - Local Properties
    private let checkoutRepository: CheckoutRepositoryProtocol
    private let cartRepository: CartRepositoryProtocol
    private let walletStorage: WalletStorageProtocol
    
    // MARK: - Computed Properties
    
    /// Get checkout response if available
    var checkoutResponse: CheckoutResponse? {
        checkoutLoadingState.data
    }
    
    var isLoading: Bool {
        checkoutLoadingState.isLoading
    }
    
    var errorMessage: String? {
        checkoutLoadingState.error?.localizedDescription
    }
    
    /// Get wallet balance
    var walletBalance: Double {
        walletLoadingState.data?.balance ?? 0.0
    }
    
    var totalCartPrice: Double {
        cartRepository.getTotalCartPrice()
    }
    
    var formattedTotalCartPrice: String {
        totalCartPrice.asFormattedCurrency
    }
    
    var formattedWalletBalance: String {
        walletBalance.asFormattedCurrency
    }
    
    /// Check balance
    var hasSufficientFunds: Bool {
        walletBalance >= totalCartPrice
    }
    
    // Check okay for Checkout or not
    var canProceedCheckout: Bool {
        hasSufficientFunds && !isLoading
    }
    
    var isCheckoutSuccessful: Bool {
        checkoutResponse?.success ?? false
    }
    
    /// Get wallet data
    var wallet: Wallet? {
        walletLoadingState.data
    }
    
    /// Get cart items from repository
    var cartItems: [CartItem] {
        (try? cartRepository.loadCart()) ?? []
    }
    
    var successMessage: String? {
        checkoutResponse?.message
    }
    
    // MARK: - Initialization
    init(
        checkoutRepository: CheckoutRepositoryProtocol = CheckoutRepository.shared,
        cartRepository: CartRepositoryProtocol = CartRepository.shared,
        walletStorage: WalletStorageProtocol = WalletStorageService.shared
    ) {
        self.checkoutRepository = checkoutRepository
        self.cartRepository = cartRepository
        self.walletStorage = walletStorage
        loadWallet()
    }
    
    // MARK: - Public Methods
    
    /// Load wallet balance
    func loadWallet() {
        walletLoadingState = .loading
        do {
            let wallet = try walletStorage.loadWallet()
            walletLoadingState = .success(wallet)
        } catch {
            walletLoadingState = .failure(error)
        }
    }
    
    /// Processes checkout operation
    @MainActor
    func processCheckout() async {
        guard canProceedCheckout else {
            checkoutLoadingState = .failure(CheckoutError.insufficientFunds)
            return
        }
        checkoutLoadingState = .loading
        do {
            let cartItems = try cartRepository.loadCart()
            let response = try await checkoutRepository.processCheckout(items: cartItems, total: totalCartPrice)
            checkoutLoadingState = .success(response)
            loadWallet()  // Refresh wallet balance
        } catch {
            checkoutLoadingState = .failure(error)
        }
    }
    
    /// Retries checkout after failure
    @MainActor
    func retryCheckout() async {
        await processCheckout()
    }
    
    /// Resets checkout state
    func resetCheckout() {
        checkoutLoadingState = .idle
    }
}
