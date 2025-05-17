import Foundation

struct GetRatesEndpoint {
    let slug: String
}

extension GetRatesEndpoint: Endpoint {
    
    typealias Response = APISingleResponse<RateDataModel>
    
    var path: String { "/v3/rates/\(slug)" }
    var method: String { "GET" }
    var queryItems: [URLQueryItem]? { nil }
    var headers: [String : String]? { nil }
    
    func body() throws -> Data? { nil }
}
