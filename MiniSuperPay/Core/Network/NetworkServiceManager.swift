import Combine
import Foundation

final class NetworkServiceManager: NetworkServiceProtocol {
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    // MARK: - Request for data
    func performRequest<T: Decodable>(_ endpoint: APIEndpoint, responseType: T.Type) -> AnyPublisher<T, NetworkError> {
        guard let request = createURLRequest(from: endpoint) else {
            return Fail(error: NetworkError.invalidURL)
                .eraseToAnyPublisher()
        }
        
        return session.dataTaskPublisher(for: request)
            .tryMap { data, response in
                // Handle the HTTP response status and ensure it's valid
                try self.handleResponse(data: data, response: response)
            }
            .mapError { error in
                // Map to our custom NetworkError
                NetworkError.networkError(error)
            }
            .tryMap { data in
                // Decode the data into the expected response type
                try self.decodeData(data, responseType: responseType)
            }
            .mapError { error in
                // Map errors to NetworkError
                error as? NetworkError ?? NetworkError.unknownError
            }
            .eraseToAnyPublisher()
    }
    
    // MARK: - Handles response validation and decoding
    /// Handles the HTTP response to check for status codes
    private func handleResponse(data: Data, response: URLResponse) throws -> Data {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }
        
        // Check for successful HTTP status codes (2xx)
        guard (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.invalidStatusCode(statusCode: httpResponse.statusCode)
        }
        
        // Return the valid data
        return data
    }
    
    /// Decodes the data into the expected type
    private func decodeData<T: Decodable>(_ data: Data, responseType: T.Type) throws -> T {
        do {
            let decodedData = try JSONDecoder().decode(T.self, from: data)
            return decodedData
        } catch {
            throw NetworkError.decodingError
        }
    }
    
    // MARK: - Creates a URLRequest from an Endpoint
    private func createURLRequest(from endpoint: APIEndpoint) -> URLRequest? {
        guard var components = URLComponents(string: endpoint.path) else { return nil }
        
        if let queryParameters = endpoint.queryParameters {
            components.queryItems = queryParameters.map {
                URLQueryItem(name: $0.key, value: $0.value)
            }
        }
        
        guard let url = components.url else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.addValue("Bearer " + APIConstants.ACCESS_TOKEN_2, forHTTPHeaderField: "Authorization")
        request.allHTTPHeaderFields = endpoint.headers
        
        if let body = endpoint.body {
            request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        }
        
        return request
    }
}
