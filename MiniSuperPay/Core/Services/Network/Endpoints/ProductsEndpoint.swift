
import Foundation

struct ProductsEndpoint {
    static func create() -> APIEndpoint {
        return APIEndpoint(
            path: APIConstants.products(),
            method: .get,
            headers: nil,
            queryParameters: nil,
            body: nil
        )
    }
}
