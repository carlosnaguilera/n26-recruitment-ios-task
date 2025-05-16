import Foundation

protocol HTTPDataDownloader: Sendable {
    func httpData(from request: URLRequest) async throws -> Data
}

extension URLSession: HTTPDataDownloader {
    
    func httpData(from request: URLRequest) async throws -> Data {
        
        let (data, response) = try await self.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }
        
        return data
    }
}
