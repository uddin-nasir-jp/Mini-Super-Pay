import Foundation

enum NetworkError: Error {
    case invalidURL
    case networkError(Error)
    case invalidResponse
    case invalidStatusCode(statusCode: Int)
    case decodingError
    case unknownError

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "The URL is invalid."
        case .networkError(error: let error):
            return "Network error \(error)."
        case .invalidResponse:
            return "Received an invalid response from the server."
        case .invalidStatusCode(statusCode: let statusCode):
            return "Invalid status code: \(statusCode)."
        case .decodingError:
            return "Failed to decode the data."
        case .unknownError:
            return "An unknown error occurred."
        }
    }
}

extension NetworkError {
    static let mockInvalidURL: NetworkError = .invalidURL
    static let mockNetworkError: NetworkError = .networkError(NSError(domain: "TestError", code: -1009))
    static let mockInvalidResponse: NetworkError = .invalidResponse
    static let mockInvalidStatusCode: NetworkError = .invalidStatusCode(statusCode: 404)
    static let mockDecodingError: NetworkError = .decodingError
    static let mockUnknownError: NetworkError = .unknownError
}
