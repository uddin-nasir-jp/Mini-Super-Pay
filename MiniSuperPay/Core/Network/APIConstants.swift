
struct APIConstants {
    static let environment = BuldEnvironment.development

    static var baseURL: String {
        return environment.baseURL
    }
    
    // MARK: - Endpoints
    
    static func products() -> String {
        return "/products"
    }
    
    static func checkout() -> String {
        return "/checkout"
    }
}
