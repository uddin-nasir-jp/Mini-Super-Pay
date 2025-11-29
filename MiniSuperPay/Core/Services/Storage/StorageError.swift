//
//  StorageError.swift
//  MiniSuperPay
//
//  Created by Nasir Uddin on 29/11/25.
//

import Foundation

// MARK: - Define Storage Error Cases

enum StorageError: LocalizedError {
    case encodingFailed
    case decodingFailed
    case saveFailed
    case loadFailed
    case dataNotFound
    
    // Error case description
    var errorDescription: String? {
        switch self {
        case .encodingFailed:
            return "Failed to encode data for storage"
        case .decodingFailed:
            return "Failed to decode stored data"
        case .saveFailed:
            return "Failed to save data"
        case .loadFailed:
            return "Failed to load data"
        case .dataNotFound:
            return "Requested data not found in storage"
        }
    }
}
