//Created by chizztectep on 22.09.2023 

import Foundation

enum Error: LocalizedError {
    case unreachableAddress(url: URL)
    case invalidResponse
    
    var errorDescription: String? {
        switch self {
        case .unreachableAddress(let url): return "\(url.absoluteString) is unreachable"
        case .invalidResponse: return "Bad response"
        }
    }
}
