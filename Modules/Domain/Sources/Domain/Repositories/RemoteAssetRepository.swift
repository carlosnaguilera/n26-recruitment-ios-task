import Foundation

public protocol RemoteAssetRepository {
    
    func fetchAllAssets() async throws -> [Asset]
}
