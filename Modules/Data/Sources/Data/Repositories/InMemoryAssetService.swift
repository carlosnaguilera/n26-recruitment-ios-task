import Domain
import Foundation

public actor InMemoryAssetService: InMemoryAssetRepository {
    
    public static let shared = InMemoryAssetService()
    
    private var storage: [Asset] = []
    
    public init() {}
    
    public func save(_ assets: [Asset]) async {
        storage = assets
    }
    
    public func getAsset(id: String) async throws(InMemoryAssetRepositoryError) -> Asset {
        
        guard let asset = storage.first(where: { $0.id == id } ) else { throw .notFound }
            
        return asset
    }
    
    public func getAllAssets() async -> [Asset] {
        storage
    }
}

