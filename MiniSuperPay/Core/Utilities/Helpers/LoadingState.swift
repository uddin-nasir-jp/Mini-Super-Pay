//
//  LoadingState.swift
//  MiniSuperPay
//
//  Created by Nasir Uddin on 28/11/25.
//

import Foundation

// MARK: - Loading States
enum LoadingState<T: Equatable>: Equatable {
    case idle
    case loading
    case success(T)
    case failure(Error)
    
    static func == (lhs: LoadingState<T>, rhs: LoadingState<T>) -> Bool {
        switch (lhs, rhs) {
        case (.idle, .idle):
            return true
        case (.loading, .loading):
            return true
        case (.success(let lhsValue), .success(let rhsValue)):
            return lhsValue == rhsValue
        case (.failure(let lhsError), .failure(let rhsError)):
            return lhsError.localizedDescription == rhsError.localizedDescription
        default:
            return false
        }
    }
    
    // MARK: - Computed Properties
    
    /// Check if currently loading
    var isLoading: Bool {
        if case .loading = self {
            return true
        }
        return false
    }
    
    /// Check if succeeded
    var isSuccess: Bool {
        if case .success = self {
            return true
        }
        return false
    }
    
    /// Check if failed
    var isFailure: Bool {
        if case .failure = self {
            return true
        }
        return false
    }
    
    /// Get success value if available
    var value: T? {
        if case .success(let value) = self {
            return value
        }
        return nil
    }
    
    /// Get error if available
    var error: Error? {
        if case .failure(let error) = self {
            return error
        }
        return nil
    }
}
