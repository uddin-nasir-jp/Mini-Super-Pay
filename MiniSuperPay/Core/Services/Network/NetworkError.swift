//
//  NetworkError.swift
//  MiniSuperPay
//
//  Created by Nasir Uddin on 28/11/25.
//

import Foundation

// MARK: - Define Network Error Cases
enum NetworkError: LocalizedError {
    case fileNotFound
    case invalidData
    case decodingError
    case checkoutFailed
    case serverError
    case noInternetConnection
    
    // Define error messages
    var errorDescription: String? {
        switch self {
        case .fileNotFound:
            return "Products data file not found"
        case .invalidData:
            return "Invalid data received from server"
        case .decodingError:
            return "Failed to decode response"
        case .checkoutFailed:
            return "Payment processing failed. Please try again."
        case .serverError:
            return "Server error occurred. Please try again later."
        case .noInternetConnection:
            return "No internet connection. Please check your network."
        }
    }
    
    // define suggestions on error cases
    var recoverySuggestion: String? {
        switch self {
        case .fileNotFound:
            return "Please contact support"
        case .invalidData, .decodingError:
            return "Please try again or contact support"
        case .checkoutFailed:
            return "Please verify your payment details and try again"
        case .serverError:
            return "Please try again in a few moments"
        case .noInternetConnection:
            return "Connect to Wi-Fi or cellular data"
        }
    }
}
