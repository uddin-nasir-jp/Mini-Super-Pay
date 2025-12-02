
enum BuldEnvironment {
    case development
    case staging
    case production

    var baseURL: String {
        switch self {
        case .development: return "https://api.mockfly.dev/mocks/bb6599e4-c50f-4e3e-89d2-95ea58ebd3ab"
        case .staging: return "https://api.mockfly.dev/mocks/bb6599e4-c50f-4e3e-89d2-95ea58ebd3ab"
        case .production: return "https://api.mockfly.dev/mocks/bb6599e4-c50f-4e3e-89d2-95ea58ebd3ab"
        }
    }
}
