import Foundation

struct GetRatesEndpoint {}

extension GetRatesEndpoint: Endpoint {
    
    typealias Response = ListDataModel<RateDataModel>
    
    var path: String { "v3/rates" }
    var method: String { "GET" }
    var queryItems: [URLQueryItem]? { nil }
    var headers: [String : String]? { nil }
    
    func body() throws -> Data? { nil }
}
