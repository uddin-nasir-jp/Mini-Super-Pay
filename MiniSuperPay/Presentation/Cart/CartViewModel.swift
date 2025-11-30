//
//  CartViewModel.swift
//  MiniSuperPay
//
//  Created by Nasir Uddin on 29/11/25.
//

import Foundation

@Observable
final class CartViewModel {
    // MARK: - Properties
    var cartLoadingState: AsyncLoadingState<[CartItem]> = .idle
    private let cartRepository: CartRepositoryProtocol
    
    // MARK: - Computed Properties
    /// Fetch cart items
    var cartItems: [CartItem] {
        cartLoadingState.data ?? []
    }
    
    var isLoading: Bool {
        cartLoadingState.isLoading
    }
    
    var errorMessage: String? {
        cartLoadingState.error?.localizedDescription
    }
    
    var isEmpty: Bool {
        cartItems.isEmpty
    }
    
    var totalPrice: Double {
        cartRepository.getTotalCartPrice()
    }
    
    var formattedTotalPrice: String {
        totalPrice.asFormattedCurrency
    }
    
    var cartCount: Int {
        cartItems.reduce(0) { $0 + $1.quantity }
    }
    
    // MARK: - Initialization
    init(cartRepository: CartRepositoryProtocol = CartRepository.shared) {
        self.cartRepository = cartRepository
        loadCart()
    }
    
    // MARK: - Public Methods
    
    /// Loads cart items from storage
    func loadCart() {
        cartLoadingState = .loading
        do {
            let items = try cartRepository.loadCart()
            cartLoadingState = .success(items)
        } catch {
            cartLoadingState = .failure(error)
        }
    }
    
    /// Add product to cart
    func addToCart(_ product: Product) {
        do {
            let updatedItems = try cartRepository.addToCart(product)
            cartLoadingState = .success(updatedItems)
        } catch {
            cartLoadingState = .failure(error)
        }
    }
    
    /// Update quantity of cart item
    func updateQuantity(for itemId: String, quantity: Int) {
        do {
            let updatedItems = try cartRepository.updateQuantity(for: itemId, quantity: quantity)
            cartLoadingState = .success(updatedItems)
        } catch {
            cartLoadingState = .failure(error)
        }
    }
    
    /// Increments quantity by 1 if less than maximum cart quantity
    func increaseQuantity(for itemId: String) {
        guard let item = cartItems.first(where: { $0.id == itemId }) else { return }
        guard item.quantity < AppConstants.maximumCartQuantity else { return }
        updateQuantity(for: itemId, quantity: item.quantity + 1)
    }
    
    /// Decrements quantity by 1 if greater than minimum cart quantity
    func decreaseQuantity(for itemId: String) {
        guard let item = cartItems.first(where: { $0.id == itemId }) else { return }
        guard item.quantity > AppConstants.minimumCartQuantity else { return }
        updateQuantity(for: itemId, quantity: item.quantity - 1)
    }
    
    /// Removes product from cart
    func removeItem(_ itemId: String) {
        do {
            let updatedItems = try cartRepository.removeFromCart(itemId)
            cartLoadingState = .success(updatedItems)
        } catch {
            cartLoadingState = .failure(error)
        }
    }
    
    /// Clears all items from cart
    func clearCart() {
        do {
            try cartRepository.clearCart()
            cartLoadingState = .success([])
        } catch {
            cartLoadingState = .failure(error)
        }
    }
}
