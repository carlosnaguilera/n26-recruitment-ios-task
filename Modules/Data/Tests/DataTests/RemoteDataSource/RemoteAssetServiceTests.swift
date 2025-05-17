import Testing
@testable import Data
import Domain

@Suite
struct RemoteAssetServiceTests {
    @Test
    func fetchAllAssets_returnsMappedAssetsAndSavesToCache() async throws {
        let api = MockAPIClient()
        let cache = MockInMemoryAssetRepository()
        let rate = RateDataModel(id: "euro", symbol: "EUR", currencySymbol: "€", type: "fiat", rateUsd: "1.0")
        let assetModel = AssetDataModel(
            id: "bitcoin", rank: "1", symbol: "BTC", name: "Bitcoin",
            supply: nil, maxSupply: nil, marketCapUsd: "1000", volumeUsd24Hr: nil,
            priceUsd: "100", changePercent24Hr: "1.0", vwap24Hr: nil, explorer: nil
        )
        api.ratesResult = rate
        api.assetsResult = [assetModel]
        let service = makeService(apiClient: api, inMemoryCache: cache)

        let assets = try await service.fetchAllAssets()

        #expect(assets.count == 1)
        #expect(assets.first?.id == "bitcoin")
        #expect(cache.savedAssets?.count == 1)
        #expect(cache.savedAssets == assets)
    }

    @Test
    func fetchAllAssets_throwsWhenAPIClientThrows() async {
        let api = MockAPIClient()
        api.shouldThrow = true
        let service = makeService(apiClient: api)

        await #expect(throws: TestError.api) {
            _ = try await service.fetchAllAssets()
        }
    }

    @Test
    func fetchAllAssets_propagatesMappingError() async throws {
        let api = MockAPIClient()
        let rate = RateDataModel(id: "euro", symbol: "EUR", currencySymbol: "€", type: "fiat", rateUsd: "1.0")
        let assetModel = AssetDataModel(
            id: "broken", rank: "1", symbol: "???", name: "Broken",
            supply: nil, maxSupply: nil, marketCapUsd: nil, volumeUsd24Hr: nil,
            priceUsd: nil, changePercent24Hr: nil, vwap24Hr: nil, explorer: nil
        )
        api.ratesResult = rate
        api.assetsResult = [assetModel]
        let service = makeService(apiClient: api)

        let assets = try? await service.fetchAllAssets()
        #expect(assets?.count == 0)
    }

    // MARK: - Helpers

    private func makeService(
        apiClient: MockAPIClient = MockAPIClient(),
        inMemoryCache: MockInMemoryAssetRepository = MockInMemoryAssetRepository()
    ) -> RemoteAssetService {
        RemoteAssetService(apiClient: apiClient, inMemoryCache: inMemoryCache)
    }
}

// MARK: - Mocks

private final class MockAPIClient: APIClient, @unchecked Sendable {
    var ratesResult: RateDataModel?
    var assetsResult: [AssetDataModel]?
    var shouldThrow = false

    func getRates(slug: String) async throws -> RateDataModel {
        if shouldThrow { throw TestError.api }
        guard let result = ratesResult else { throw TestError.api }
        return result
    }

    func getAssets(limit: Int) async throws -> [AssetDataModel] {
        if shouldThrow { throw TestError.api }
        guard let result = assetsResult else { throw TestError.api }
        return result
    }
}

private final class MockInMemoryAssetRepository: InMemoryAssetRepository, @unchecked Sendable {
    var savedAssets: [Asset]?
    func save(_ assets: [Asset]) async {
        savedAssets = assets
    }
    func getAllAssets() async -> [Asset] { [] }
    func getAsset(id: String) async throws(InMemmoryAssetRepositoryError) -> Asset {
        throw InMemmoryAssetRepositoryError.notFound
    }
}

private enum TestError: Error, Equatable {
    case api
    case mapping
}
