import Domain
import Foundation

public struct RemoteAssetService: RemoteAssetRepository, Sendable {
    
    enum Error: Swift.Error {
        case noEuroRate
    }
    
    private let apiClient: APIClient
    private let inMemoryCache: InMemoryAssetRepository
    
    public init() {
        // As we are having trouble with real CoinCap API usage we use a mock one
        self.init(apiClient: CoinCapAPIClient(downloader: MockDataDownloader()))
    }
    
    init(apiClient: APIClient, inMemoryCache: InMemoryAssetRepository = InMemoryAssetService.shared) {
        self.apiClient = apiClient
        self.inMemoryCache = inMemoryCache
    }
    
    public func fetchAllAssets() async throws -> [Asset] {
        
        async let ratesDataModels = try apiClient.getRates()
        async let assetsDataModels = try apiClient.getAssets(limit: 100)
        
        let assets = try await AssetMapper.mapToAssets(assetsDataModels: assetsDataModels,
                                                       ratesDataModels: ratesDataModels)
        await inMemoryCache.save(assets)
        return assets
    }
}
