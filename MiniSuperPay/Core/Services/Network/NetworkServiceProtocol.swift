
import Foundation

protocol NetworkServiceProtocol {
    // Perform network request
    func performRequestAsync<T: Decodable>(_ endpoint: APIEndpoint, responseType: T.Type) async throws -> T
}
