import Foundation

protocol Endpoint {
    
    associatedtype Response: Decodable

    var path: String { get }
    var method: String { get }
    var queryItems: [URLQueryItem]? { get }
    var headers: [String: String]? { get }

    func body() throws -> Data?
}

