import Foundation

struct APIEndpoint {
    let path: String
    let method: HTTPMethod
    let headers: [String: String]?
    let queryParameters: [String: String]?
    let body: [String: Any]?
    
    init(path: String, method: HTTPMethod, headers: [String: String]? = nil, queryParameters: [String: String]? = nil, body: [String: Any]? = nil) {
        self.path = APIConstants.baseURL + path
        self.method = method
        self.headers = headers
        self.queryParameters = queryParameters
        self.body = body
    }
}
