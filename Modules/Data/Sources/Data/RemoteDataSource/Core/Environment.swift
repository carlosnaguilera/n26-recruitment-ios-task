import Foundation

enum Environment {
    
    case debug
    case release
    
    static var current: Self {
    #if DEBUG
        .debug
    #else
        .release
    #endif
    }
    
    var baseURL: String {
        switch self {
        case .debug:
            "https://rest.coincap.io"
        case .release:
            "https://rest.coincap.io"
        }
    }
    
    var apiKey: String {
        switch self {
        case .debug:
            "8bd86b9bf949fe969f9ffe9dc927b916a10e37f551d2a68c806a0094bb932a6b"
        case .release:
            "8bd86b9bf949fe969f9ffe9dc927b916a10e37f551d2a68c806a0094bb932a6b"
        }
    }
}

