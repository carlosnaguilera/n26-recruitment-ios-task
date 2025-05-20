import Foundation

public enum InMemoryAssetRepositoryError: Error {
    case notFound
}

public protocol InMemoryAssetRepository: Sendable {
    
    func save(_ assets: [Asset]) async
    func getAsset(id: String) async throws(InMemoryAssetRepositoryError) -> Asset
    func getAllAssets() async -> [Asset]
    
}
