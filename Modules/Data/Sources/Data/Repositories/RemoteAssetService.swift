import Domain
import Foundation

public struct RemoteAssetService: RemoteAssetRepository, Sendable {
    
    enum Error: Swift.Error {
        case noEuroRate
    }
    
    private let apiClient: APIClient
    private let inMemoryCache: InMemoryAssetRepository
    
    public init() {
        self.init(apiClient: CoinCapAPIClient())
    }
    
    init(apiClient: APIClient, inMemoryCache: InMemoryAssetRepository = InMemoryAssetService.shared) {
        self.apiClient = apiClient
        self.inMemoryCache = inMemoryCache
    }
    
    public func fetchAllAssets() async throws -> [Asset] {
        
        async let euroRateDataModel = try apiClient.getRates(slug: "euro")
        async let assetsDataModels = try apiClient.getAssets(limit: 100)
        
        let assets = try await AssetMapper.mapToDomain(assetsDataModels: assetsDataModels,
                                                       euroRateDataModel: euroRateDataModel)
        await inMemoryCache.save(assets)
        return assets
    }
}
