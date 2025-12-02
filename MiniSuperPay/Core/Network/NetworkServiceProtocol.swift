
import Foundation
import Combine

protocol NetworkServiceProtocol {
    func performRequest<T: Decodable>(_ endpoint: APIEndpoint, responseType: T.Type) -> AnyPublisher<T, NetworkError>
}
