//
//  CartViewModelTests.swift
//  MiniSuperPayTests
//
//  Created by Nasir Uddin on 01/12/25.
//

import XCTest
@testable import MiniSuperPay

final class CartViewModelTests: XCTestCase {
    // MARK: - PROPERTIES
    var viewModel: CartViewModel!
    var mockRepository: MockCartRepository!
    
    // MARK: - setUp and tearDown Items
    
    override func setUp() {
        super.setUp()
        mockRepository = MockCartRepository()
        viewModel = CartViewModel(cartRepository: mockRepository)
    }
    
    override func tearDown() {
        viewModel = nil
        mockRepository = nil
        super.tearDown()
    }
    
    // MARK: - Test cases for Adding Cart Items
    
    func test_addToCart_newProduct_shouldAddItemWithQuantityOne() {
        viewModel.addToCart(Product.testProduct1)
        
        XCTAssertEqual(viewModel.cartItems.count, 1)
        XCTAssertEqual(viewModel.cartItems.first?.quantity, 1)
    }
    
    func test_addToCart_existingProduct_shouldIncreaseQuantity() {
        let product = Product.testProduct1
        
        viewModel.addToCart(product)
        viewModel.addToCart(product)
        
        XCTAssertEqual(viewModel.cartItems.count, 1)
        XCTAssertEqual(viewModel.cartItems.first?.quantity, 2)
    }
    
    // MARK: - Test cases for Quantity Management
    
    func test_increaseQuantity_shouldIncrementByOne() {
        viewModel.addToCart(Product.testProduct1)
        let itemId = viewModel.cartItems.first!.id
        
        viewModel.increaseQuantity(for: itemId)
        
        XCTAssertEqual(viewModel.cartItems.first?.quantity, 2)
    }
    
    func test_decreaseQuantity_shouldDecrementByOne() {
        viewModel.addToCart(Product.testProduct1)
        let itemId = viewModel.cartItems.first!.id
        viewModel.increaseQuantity(for: itemId)
        
        viewModel.decreaseQuantity(for: itemId)
        
        XCTAssertEqual(viewModel.cartItems.first?.quantity, 1)
    }
    
    // MARK: - Test cases for Removing cart Items
    
    func test_removeItem_shouldRemoveFromCart() {
        viewModel.addToCart(Product.testProduct1)
        let itemId = viewModel.cartItems.first!.id
        
        viewModel.removeItem(itemId)
        
        XCTAssertTrue(viewModel.cartItems.isEmpty)
    }
    
    func test_clearCart_shouldRemoveAllItems() {
        viewModel.addToCart(Product.testProduct1)
        viewModel.addToCart(Product.testProduct2)
        
        viewModel.clearCart()
        
        XCTAssertTrue(viewModel.cartItems.isEmpty)
    }
    
    // MARK: - Test cases for Price Calculations
    
    func test_totalPrice_shouldCalculateCorrectSum() {
        viewModel.addToCart(Product.testProduct1)
        viewModel.addToCart(Product.testProduct2)
        
        XCTAssertEqual(viewModel.totalPrice, 30.0, accuracy: 0.01)
    }
    
    // MARK: - Test cases for Error Handling
    
    func test_addToCart_withStorageError_shouldHandleGracefully() {
        mockRepository.shouldThrowError = true
        mockRepository.errorToThrow = StorageError.saveFailed
        
        viewModel.addToCart(Product.testProduct1)
        
        XCTAssertNotNil(viewModel.errorMessage)
        XCTAssertTrue(viewModel.cartItems.isEmpty)
    }
}
