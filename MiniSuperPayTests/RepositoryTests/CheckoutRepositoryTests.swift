//
//  CheckoutRepositoryTests.swift
//  MiniSuperPayTests
//
//  Created by Nasir Uddin on 01/12/25.
//

import XCTest
@testable import MiniSuperPay

final class CheckoutRepositoryTests: XCTestCase {
    // MARK: - PROPERTIES
    var checkoutRepo: MockCheckoutRepository!
    
    // MARK: - Test Lifecycle
    override func setUp() {
        super.setUp()
        checkoutRepo = MockCheckoutRepository()
    }
    
    override func tearDown() {
        checkoutRepo = nil
        super.tearDown()
    }
    
    // MARK: - Validation Tests
    func test_validateCheckout_withValidItemsAndSufficientFunds_shouldSucceed() throws {
        // Given
        let items = [CartItem.testCartItem1]
        let walletBalance = 1000.0
        
        // When/Then
        XCTAssertNoThrow(
            try checkoutRepo.validateCheckout(items: items, walletBalance: walletBalance),
            "Validation should succeed with sufficient funds"
        )
    }
    
    func test_validateCheckout_withEmptyCart_shouldThrowEmptyCartError() {
        // Given
        let items: [CartItem] = []
        let walletBalance = 1000.0
        checkoutRepo.shouldThrowError = false
        
        // When/Then
        XCTAssertThrowsError(
            try checkoutRepo.validateCheckout(items: items, walletBalance: walletBalance),
            "Should throw error for empty cart"
        ) { error in
            XCTAssertTrue(error is CheckoutError, "Error should be of type CheckoutError")
            XCTAssertEqual(error as? CheckoutError, .emptyCart, "Should throw emptyCart error")
        }
    }
    
    func test_validateCheckout_withInsufficientFunds_shouldThrowInsufficientFundsError() {
        // Given
        let items = [CartItem.testCartItem1]
        let walletBalance = 1000.0
        checkoutRepo.shouldThrowError = true
        
        // When/Then
        XCTAssertThrowsError(
            try checkoutRepo.validateCheckout(items: items, walletBalance: walletBalance),
            "Should throw error for insufficient funds"
        ) { error in
            XCTAssertTrue(error is CheckoutError, "Error should be of type CheckoutError")
            XCTAssertEqual(
                error as? CheckoutError,
                .insufficientFunds,
                "Should throw insufficientFunds error"
            )
        }
    }
    
    // MARK: - Process Checkout Tests (Async)
    func test_processCheckout_withSufficientFunds_shouldReturnSuccessResponse() async throws {
        // Given
        let items = [CartItem.testCartItem1] // 10.0
        let total = 10.0
        checkoutRepo.shouldThrowError = false
        checkoutRepo.mockResponse = CheckoutResponse.testSuccessResponse
        
        // When
        let response = try await checkoutRepo.processCheckout(items: items, total: total)
        
        // Then
        XCTAssertTrue(response.success, "Response should indicate success")
        XCTAssertNotNil(response.transactionId, "Transaction ID should be present")
        XCTAssertEqual(checkoutRepo.processCheckoutCallCount, 1, "processCheckout should be called once")
    }
    
    func test_processCheckout_withInsufficientFunds_shouldThrowError() async {
        // Given
        let items = [CartItem.testCartItem1]
        let total = 50.0
        checkoutRepo.shouldThrowError = true
        checkoutRepo.errorToThrow = CheckoutError.insufficientFunds
        
        // When/Then
        do {
            _ = try await checkoutRepo.processCheckout(items: items, total: total)
            XCTFail("Should throw insufficientFunds error")
        } catch {
            XCTAssertTrue(error is CheckoutError, "Error should be of type CheckoutError")
            XCTAssertEqual(
                error as? CheckoutError,
                .insufficientFunds,
                "Should throw insufficientFunds error"
            )
        }
    }
    
    func test_processCheckout_withEmptyCart_shouldThrowError() async {
        // Given
        let items: [CartItem] = []
        let total = 0.0
        checkoutRepo.shouldThrowError = true
        checkoutRepo.errorToThrow = CheckoutError.emptyCart
        
        // When/Then
        do {
            _ = try await checkoutRepo.processCheckout(items: items, total: total)
            XCTFail("Should throw emptyCart error")
        } catch {
            XCTAssertTrue(error is CheckoutError, "Error should be of type CheckoutError")
            XCTAssertEqual(error as? CheckoutError, .emptyCart, "Should throw emptyCart error")
        }
    }
    
    func test_processCheckout_shouldStoreProcessedItems() async throws {
        // Given
        let items = [CartItem.testCartItem1, CartItem.testCartItem2]
        let total = 50.0
        checkoutRepo.shouldThrowError = false
        
        // When
        _ = try await checkoutRepo.processCheckout(items: items, total: total)
        
        // Then
        XCTAssertNotNil(checkoutRepo.lastProcessedItems, "Should store processed items")
        XCTAssertEqual(checkoutRepo.lastProcessedItems?.count, 2, "Should store all items")
        XCTAssertEqual(checkoutRepo.lastProcessedTotal, total, "Should store total amount")
    }
    
    func test_processCheckout_shouldSimulateNetworkDelay() async throws {
        // Given
        let items = [CartItem.testCartItem1]
        let total = 10.0
        checkoutRepo.simulatedDelay = 1_000_000_000 // 1 second in nanoseconds
        checkoutRepo.shouldThrowError = false
        
        let startTime = Date()
        
        // When
        _ = try await checkoutRepo.processCheckout(items: items, total: total)
        
        let endTime = Date()
        let duration = endTime.timeIntervalSince(startTime)
        
        // Then
        XCTAssertGreaterThanOrEqual(
            duration,
            1.0,
            "Should take at least 1 second due to simulated delay"
        )
    }
    
    func test_processCheckout_multipleItems_shouldCalculateCorrectTotal() async throws {
        // Given
        let item1 = CartItem.testCartItem1 // 10.0 * 1 = 10.0
        let item2 = CartItem.testCartItem2 // 20.0 * 2 = 40.0
        let items = [item1, item2]
        let total = 50.0
        checkoutRepo.shouldThrowError = false
        
        // When
        _ = try await checkoutRepo.processCheckout(items: items, total: total)
        
        // Then
        XCTAssertNotNil(checkoutRepo.lastProcessedTotal, "Last processed total should not be nil")
        XCTAssertEqual(checkoutRepo.lastProcessedTotal ?? 0.0, 50.0, accuracy: 0.01, "Total should be 50.0")
    }
    
    // MARK: - Success Response Tests
    func test_processCheckout_successResponse_shouldContainTransactionId() async throws {
        // Given
        let items = [CartItem.testCartItem1]
        let total = 10.0
        checkoutRepo.mockResponse = CheckoutResponse.testSuccessResponse
        checkoutRepo.shouldThrowError = false
        
        // When
        let response = try await checkoutRepo.processCheckout(items: items, total: total)
        
        // Then
        XCTAssertNotNil(response.transactionId, "Success response should have transaction ID")
        XCTAssertFalse(
            response.transactionId!.isEmpty,
            "Transaction ID should not be empty"
        )
    }
    
    // MARK: - Error Response Tests
    func test_processCheckout_failureResponse_shouldReturnFailureMessage() async throws {
        // Given
        let items = [CartItem.testCartItem1]
        let total = 10.0
        checkoutRepo.mockResponse = CheckoutResponse.testFailureResponse
        checkoutRepo.shouldThrowError = false
        
        // When
        let response = try await checkoutRepo.processCheckout(items: items, total: total)
        
        // Then
        XCTAssertFalse(response.success, "Response should indicate failure")
        XCTAssertNotNil(response.message, "Failure response should have message")
    }
    
    // MARK: - Concurrent Requests Tests
    func test_processCheckout_concurrentRequests_shouldHandleMultipleRequests() async throws {
        // Given
        let items = [CartItem.testCartItem1]
        let total = 10.0
        checkoutRepo.shouldThrowError = false
        
        // When - make 3 concurrent requests
        async let request1 = checkoutRepo.processCheckout(items: items, total: total)
        async let request2 = checkoutRepo.processCheckout(items: items, total: total)
        async let request3 = checkoutRepo.processCheckout(items: items, total: total)
        
        let results = try await [request1, request2, request3]
        
        // Then
        XCTAssertEqual(results.count, 3, "Should complete all 3 requests")
        XCTAssertTrue(results.allSatisfy { $0.success }, "All requests should succeed")
        XCTAssertEqual(checkoutRepo.processCheckoutCallCount, 3, "Should process 3 requests")
    }
    
    // MARK: - Reset Tests
    func test_reset_shouldClearAllTrackedData() async throws {
        // Given
        let items = [CartItem.testCartItem1]
        let total = 10.0
        _ = try await checkoutRepo.processCheckout(items: items, total: total)
        
        // When
        checkoutRepo.reset()
        
        // Then
        XCTAssertEqual(checkoutRepo.processCheckoutCallCount, 0, "Call count should be reset")
        XCTAssertNil(checkoutRepo.lastProcessedItems, "Last processed items should be nil")
        XCTAssertNil(checkoutRepo.lastProcessedTotal, "Last processed total should be nil")
        XCTAssertFalse(checkoutRepo.shouldThrowError, "shouldThrowError should be reset to false")
    }
}
