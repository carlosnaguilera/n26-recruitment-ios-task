import Foundation

struct MockDataDownloader: HTTPDataDownloader {
    
    enum RequestURL {
        case assetsList
        case rates
        
        init?(request: URLRequest) {
            
            guard let url = request.url?.absoluteString,
            let urlComponents = URLComponents(string: url) else { return nil }
            
            switch urlComponents.path {
            case "/v3/assets":
                self = .assetsList
            case "/v3/rates":
                self = .rates
            default:
                return nil
            }
        }
        
        var resourceURL: URL? {
            switch self {
            case .assetsList:
                Bundle.module.url(forResource: "assets_list_response", withExtension: "json")
            case .rates:
                Bundle.module.url(forResource: "rates_response", withExtension: "json")
            }
        }
    }
    
    enum Error: Swift.Error {
        case failedToLoadDataFromBundle
        case wrongURL
    }
    
    func httpData(from request: URLRequest) async throws(Error) -> Data {
        
        guard let requestURL = RequestURL(request: request) else {
            throw .wrongURL
        }
        
        guard let mockDataURL = requestURL.resourceURL,
              let data = try? Data(contentsOf: mockDataURL) else {
            throw .failedToLoadDataFromBundle
        }
        
        return data
    }
}
