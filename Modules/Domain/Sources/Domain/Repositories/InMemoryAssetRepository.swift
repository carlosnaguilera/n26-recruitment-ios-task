import Foundation

public enum InMemmoryAssetRepositoryError: Error {
    case notFound
}

public protocol InMemoryAssetRepository: Sendable {
    
    func save(_ assets: [Asset]) async
    func getAsset(id: String) async throws(InMemmoryAssetRepositoryError) -> Asset
    func getAllAssets() async -> [Asset]
    
}
