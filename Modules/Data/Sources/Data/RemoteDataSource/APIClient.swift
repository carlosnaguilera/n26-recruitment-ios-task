import Foundation

protocol APIClient: Sendable {
    func getAssets(limit: Int) async throws -> [AssetDataModel]
    func getRates(slug: String) async throws -> RateDataModel
}

final class CoinCapAPIClient: APIClient {
    
    private let baseURLString: String
    private let downloader: HTTPDataDownloader
    private let token: String
    
    init(baseURL: String = Environment.current.baseURL,
         downloader: HTTPDataDownloader = URLSession.shared,
         token: String = Environment.current.apiKey) {
        self.baseURLString = baseURL
        self.downloader = downloader
        self.token = token
    }
    
    func getAssets(limit: Int) async throws -> [AssetDataModel] {
        let endpoint = GetAssetsEndpoint(limit: limit)
        let getAssetsResponse = try await performRequest(for: endpoint)
        return getAssetsResponse.data
    }
    
    func getRates(slug: String) async throws -> RateDataModel {
        let endpoint = GetRatesEndpoint(slug: slug)
        let getRatesResponse = try await performRequest(for: endpoint)
        return getRatesResponse.data
    }
        
    private func performRequest<E: Endpoint>(for endpoint: E) async throws -> E.Response {

        let request = try buildRequest(from: endpoint)

        let data = try await downloader.httpData(from: request)
        
        let decoder = JSONDecoder()
        return try decoder.decode(E.Response.self, from: data)
    }
    
    private func buildRequest<E: Endpoint>(from endpoint: E) throws -> URLRequest {
        
        guard let baseURL = URL(string: baseURLString),
              var components = URLComponents(url: baseURL.appendingPathComponent(endpoint.path),
                                             resolvingAgainstBaseURL: false) else {
            throw URLError(.badURL)
        }

        components.queryItems = endpoint.queryItems

        guard let url = components.url else {
            throw URLError(.badURL)
        }

        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method
        request.httpBody = try endpoint.body()
        endpoint.headers?.forEach { key, value in
            request.setValue(value, forHTTPHeaderField: key)
        }
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

        return request
    }
}
