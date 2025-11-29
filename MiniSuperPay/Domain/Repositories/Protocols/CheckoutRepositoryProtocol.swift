//
//  CheckoutRepositoryProtocol.swift
//  MiniSuperPay
//
//  Created by Nasir Uddin on 28/11/25.
//

import Foundation

protocol CheckoutRepositoryProtocol {
    /// Processes checkout by deducting wallet balance and clearing cart 
    func processCheckout(items: [CartItem], total: Double) async throws -> CheckoutResponse
    
    /// Validates if checkout can proceed or not
    func validateCheckout(items: [CartItem], walletBalance: Double) throws
}
