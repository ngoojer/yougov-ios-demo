import Network
import Foundation

struct NetworkManager {
    static var isNetworkAvailable: Bool {
        NetworkMonitor.shared.isConnected
    }
}

enum NetworkError: Error, LocalizedError {
    case noIntenet
    case invalidRequest
    case invalidResponse
    case dataLoadingError(_ statusCode: Int, _ data: Data)
    case jsonDecodingError
    
    var errorDescription: String?{
        switch self {
        case .noIntenet: return "No Internet conection"
        case .invalidRequest: return "Invalid request"
        case .invalidResponse: return "Invalid reponse"
        case .dataLoadingError(let code, _): return "Error Code = \(code)"
        case .jsonDecodingError: return "JSON decoding failed."
        }
    }
}

