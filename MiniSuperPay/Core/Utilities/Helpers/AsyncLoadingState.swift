//
//  AsyncLoadingState.swift
//  MiniSuperPay
//
//  Created by Nasir Uddin on 30/11/25.
//

import Foundation

/// Represents the loading state of an asynchronous operation
enum AsyncLoadingState<T> {
    case idle
    case loading
    case success(T)
    case failure(Error)
    
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
    
    /// Returns the success state data if available
    var data: T? {
        if case .success(let data) = self {
            return data
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
