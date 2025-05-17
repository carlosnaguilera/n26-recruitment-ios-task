import Foundation

struct GetAssetsEndpoint {
    let limit: Int
}

extension GetAssetsEndpoint: Endpoint {
    
    typealias Response = APIListResponse<AssetDataModel>
    
    var path: String { "/v3/assets" }
    var method: String { "GET" }
    var queryItems: [URLQueryItem]? { [URLQueryItem(name: "limit", value: "\(limit)")] }
    var headers: [String: String]? { nil }
    
    func body() throws -> Data? { nil }
}
