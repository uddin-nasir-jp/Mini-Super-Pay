//
//  CartViewModelTests.swift
//  MiniSuperPayTests
//
//  Created by Nasir Uddin on 01/12/25.
//

import XCTest
@testable import MiniSuperPay

final class CartViewModelTests: XCTestCase {
    // MARK: - System Under Test
    var sut: CartViewModel!
    var mockRepository: MockCartRepository!
    
    // MARK: - Test Lifecycle
    override func setUp() {
        super.setUp()
        mockRepository = MockCartRepository()
        sut = CartViewModel(cartRepository: mockRepository)
    }
    
    override func tearDown() {
        sut = nil
        mockRepository = nil
        super.tearDown()
    }
    
    // MARK: - Initial State Tests
    func test_initialState_shouldBeEmpty() {
        // Given - setUp creates empty cart
        
        // When - check initial state
        let items = sut.cartItems
        let total = sut.totalPrice
        let isEmpty = sut.isEmpty
        
        // Then
        XCTAssertTrue(items.isEmpty, "Cart should be empty initially")
        XCTAssertEqual(total, 0.0, accuracy: 0.01, "Total should be 0.0 for empty cart")
        XCTAssertTrue(isEmpty, "isEmpty should return true for empty cart")
    }
    
    func test_initialState_cartCount_shouldBeZero() {
        // Given - setUp creates empty cart
        
        // When
        let count = sut.cartCount
        
        // Then
        XCTAssertEqual(count, 0, "Cart count should be 0 initially")
    }
    
    // MARK: - Add To Cart Tests
    func test_addToCart_newProduct_shouldAddItemWithQuantityOne() {
        // Given
        let product = Product.testProduct1
        
        // When
        sut.addToCart(product)
        
        // Then
        XCTAssertEqual(sut.cartItems.count, 1, "Cart should contain 1 item")
        XCTAssertEqual(sut.cartItems.first?.product.id, product.id, "Product ID should match")
        XCTAssertEqual(sut.cartItems.first?.quantity, 1, "Quantity should be 1")
        XCTAssertFalse(sut.isEmpty, "Cart should not be empty")
        XCTAssertEqual(mockRepository.addToCartCallCount, 1, "addToCart should be called once")
    }
    
    func test_addToCart_existingProduct_shouldIncreaseQuantity() {
        // Given
        let product = Product.testProduct1
        sut.addToCart(product)
        
        // When - add same product again
        sut.addToCart(product)
        
        // Then
        XCTAssertEqual(sut.cartItems.count, 1, "Should still have 1 unique item")
        XCTAssertEqual(sut.cartItems.first?.quantity, 2, "Quantity should increase to 2")
        XCTAssertEqual(mockRepository.addToCartCallCount, 2, "addToCart should be called twice")
    }
    
    func test_addToCart_multipleDifferentProducts_shouldAddAllItems() {
        // Given
        let product1 = Product.testProduct1
        let product2 = Product.testProduct2
        let product3 = Product.testProduct3
        
        // When
        sut.addToCart(product1)
        sut.addToCart(product2)
        sut.addToCart(product3)
        
        // Then
        XCTAssertEqual(sut.cartItems.count, 3, "Cart should contain 3 different items")
        XCTAssertEqual(sut.cartCount, 3, "Total quantity should be 3")
    }
    
    // MARK: - Increase Quantity Tests
    func test_increaseQuantity_shouldIncrementByOne() {
        // Given
        let product = Product.testProduct1
        sut.addToCart(product)
        let itemId = sut.cartItems.first!.id
        
        // When
        sut.increaseQuantity(for: itemId)
        
        // Then
        XCTAssertEqual(sut.cartItems.first?.quantity, 2, "Quantity should increase to 2")
        XCTAssertEqual(mockRepository.updateQuantityCallCount, 1, "updateQuantity should be called")
    }
    
    func test_increaseQuantity_atMaximum_shouldNotIncrement() {
        // Given
        let product = Product.testProduct1
        sut.addToCart(product)
        let itemId = sut.cartItems.first!.id
        
        // Set quantity to maximum
        for _ in 1..<AppConstants.maximumCartQuantity {
            sut.increaseQuantity(for: itemId)
        }
        let quantityBeforeMax = sut.cartItems.first?.quantity
        
        // When - try to increase beyond maximum
        sut.increaseQuantity(for: itemId)
        
        // Then
        XCTAssertEqual(
            sut.cartItems.first?.quantity,
            quantityBeforeMax,
            "Quantity should not exceed maximum"
        )
        XCTAssertEqual(
            sut.cartItems.first?.quantity,
            AppConstants.maximumCartQuantity,
            "Quantity should stay at maximum"
        )
    }
    
    func test_increaseQuantity_nonExistentItem_shouldDoNothing() {
        // Given
        let product = Product.testProduct1
        sut.addToCart(product)
        
        // When - try to increase non-existent item
        sut.increaseQuantity(for: "non-existent-id")
        
        // Then
        XCTAssertEqual(sut.cartItems.first?.quantity, 1, "Quantity should remain unchanged")
    }
    
    // MARK: - Decrease Quantity Tests
    func test_decreaseQuantity_shouldDecrementByOne() {
        // Given
        let product = Product.testProduct1
        sut.addToCart(product)
        let itemId = sut.cartItems.first!.id
        sut.increaseQuantity(for: itemId) // Make quantity = 2
        
        // When
        sut.decreaseQuantity(for: itemId)
        
        // Then
        XCTAssertEqual(sut.cartItems.first?.quantity, 1, "Quantity should decrease to 1")
    }
    
    func test_decreaseQuantity_atMinimum_shouldNotDecrement() {
        // Given
        let product = Product.testProduct1
        sut.addToCart(product)
        let itemId = sut.cartItems.first!.id
        
        // When - try to decrease below minimum
        sut.decreaseQuantity(for: itemId)
        
        // Then
        XCTAssertEqual(
            sut.cartItems.first?.quantity,
            AppConstants.minimumCartQuantity,
            "Quantity should stay at minimum"
        )
    }
    
    func test_decreaseQuantity_nonExistentItem_shouldDoNothing() {
        // Given
        let product = Product.testProduct1
        sut.addToCart(product)
        
        // When - try to decrease non-existent item
        sut.decreaseQuantity(for: "non-existent-id")
        
        // Then
        XCTAssertEqual(sut.cartItems.first?.quantity, 1, "Quantity should remain unchanged")
    }
    
    // MARK: - Remove Item Tests
    func test_removeFromCart_shouldRemoveItem() {
        // Given
        let product = Product.testProduct1
        sut.addToCart(product)
        let itemId = sut.cartItems.first!.id
        
        // When
        sut.removeItem(itemId)
        
        // Then
        XCTAssertTrue(sut.cartItems.isEmpty, "Cart should be empty after removing item")
        XCTAssertTrue(sut.isEmpty, "isEmpty should return true")
        XCTAssertEqual(mockRepository.removeFromCartCallCount, 1, "removeFromCart should be called")
    }
    
    func test_removeFromCart_withMultipleItems_shouldRemoveOnlySpecifiedItem() {
        // Given
        let product1 = Product.testProduct1
        let product2 = Product.testProduct2
        sut.addToCart(product1)
        sut.addToCart(product2)
        let itemIdToRemove = sut.cartItems.first!.id
        
        // When
        sut.removeItem(itemIdToRemove)
        
        // Then
        XCTAssertEqual(sut.cartItems.count, 1, "Should have 1 item remaining")
        XCTAssertFalse(
            sut.cartItems.contains { $0.id == itemIdToRemove },
            "Removed item should not be in cart"
        )
    }
    
    // MARK: - Clear Cart Tests
    func test_clearCart_shouldRemoveAllItems() {
        // Given
        let product1 = Product.testProduct1
        let product2 = Product.testProduct2
        sut.addToCart(product1)
        sut.addToCart(product2)
        
        // When
        sut.clearCart()
        
        // Then
        XCTAssertTrue(sut.cartItems.isEmpty, "Cart should be empty after clearing")
        XCTAssertTrue(sut.isEmpty, "isEmpty should return true")
        XCTAssertEqual(sut.totalPrice, 0.0, accuracy: 0.01, "Total should be 0.0")
        XCTAssertEqual(mockRepository.clearCartCallCount, 1, "clearCart should be called")
    }
    
    func test_clearCart_whenAlreadyEmpty_shouldStillSucceed() {
        // Given - cart is already empty
        
        // When
        sut.clearCart()
        
        // Then
        XCTAssertTrue(sut.cartItems.isEmpty, "Cart should remain empty")
        XCTAssertEqual(mockRepository.clearCartCallCount, 1, "clearCart should still be called")
    }
    
    // MARK: - Computed Properties Tests
    func test_totalPrice_shouldCalculateCorrectSum() {
        // Given
        let product1 = Product.testProduct1 // price: 10.0
        let product2 = Product.testProduct2 // price: 20.0
        sut.addToCart(product1)
        sut.addToCart(product2)
        sut.addToCart(product2) // quantity = 2 for product2
        
        // When
        let total = sut.totalPrice
        
        // Then
        // 10.0 + (20.0 * 2) = 50.0
        XCTAssertEqual(total, 50.0, accuracy: 0.01, "Total should be 50.0")
    }
    
    func test_cartCount_shouldReturnTotalQuantity() {
        // Given
        let product1 = Product.testProduct1
        let product2 = Product.testProduct2
        sut.addToCart(product1) // quantity = 1
        sut.addToCart(product2) // quantity = 1
        sut.addToCart(product2) // quantity = 2
        
        // When
        let count = sut.cartCount
        
        // Then
        XCTAssertEqual(count, 3, "Total count should be 3 (1 + 2)")
    }
    
    func test_formattedTotalPrice_shouldReturnCurrencyString() {
        // Given
        let product = Product.testProduct1 // price: 10.0
        sut.addToCart(product)
        
        // When
        let formatted = sut.formattedTotalPrice
        
        // Then
        XCTAssertTrue(formatted.contains("$"), "Formatted price should contain currency symbol")
        XCTAssertTrue(formatted.contains("10"), "Formatted price should contain amount")
    }
    
    // MARK: - Error Handling Tests
    func test_addToCart_whenRepositoryThrowsError_shouldHandleGracefully() {
        // Given
        let product = Product.testProduct1
        mockRepository.shouldThrowError = true
        mockRepository.errorToThrow = StorageError.saveFailed
        
        // When
        sut.addToCart(product)
        
        // Then
        XCTAssertNotNil(sut.errorMessage, "Error message should be set")
        XCTAssertTrue(sut.cartItems.isEmpty, "Cart should remain empty on error")
    }
    
    func test_removeFromCart_whenRepositoryThrowsError_shouldHandleGracefully() {
        // Given
        mockRepository.shouldThrowError = true
        mockRepository.errorToThrow = StorageError.saveFailed
        
        // When
        sut.removeItem("any-id")
        
        // Then
        XCTAssertNotNil(sut.errorMessage, "Error message should be set")
    }
}
