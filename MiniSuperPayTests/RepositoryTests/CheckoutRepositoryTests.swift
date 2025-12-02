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
    var repository: MockCheckoutRepository!
    
    // MARK: - setUp and tearDown Items
    
    override func setUp() {
        super.setUp()
        repository = MockCheckoutRepository()
    }
    
    override func tearDown() {
        repository = nil
        super.tearDown()
    }
    
    // MARK: - Test cases for Checkout Processing
    
    func test_processCheckout_withSufficientFunds_shouldReturnSuccessResponse() async throws {
        let items = [CartItem.testCartItem1]
        repository.mockResponse = CheckoutResponse.testSuccessResponse
        
        let response = try await repository.processCheckout(items: items, total: 10.0)
        let isSuccess = response.success
        let transactionId = response.transactionId
        
        XCTAssertTrue(isSuccess)
        XCTAssertNotNil(transactionId)
    }
    
    func test_processCheckout_withInsufficientFunds_shouldThrowError() async {
        repository.shouldThrowError = true
        repository.errorToThrow = CheckoutError.insufficientFunds
        
        do {
            try await repository.processCheckout(items: [CartItem.testCartItem1], total: 50.0)
            XCTFail("Should throw error")
        } catch {
            XCTAssertEqual(error as? CheckoutError, .insufficientFunds)
        }
    }
    
    func test_processCheckout_withEmptyCart_shouldThrowError() async {
        repository.shouldThrowError = true
        repository.errorToThrow = CheckoutError.emptyCart
        
        do {
            try await repository.processCheckout(items: [], total: 0.0)
            XCTFail("Should throw error")
        } catch {
            XCTAssertEqual(error as? CheckoutError, .emptyCart)
        }
    }
    
    // MARK: - Test cases for Validation
    
    func test_validateCheckout_withSufficientFunds_shouldSucceed() throws {
        let items = [CartItem.testCartItem1]
        
        XCTAssertNoThrow(try repository.validateCheckout(items: items, walletBalance: 1000.0))
    }
    
    func test_validateCheckout_withEmptyCart_shouldThrowError() {
        XCTAssertThrowsError(try repository.validateCheckout(items: [], walletBalance: 1000.0)) { error in
            XCTAssertEqual(error as? CheckoutError, .emptyCart)
        }
    }
}
