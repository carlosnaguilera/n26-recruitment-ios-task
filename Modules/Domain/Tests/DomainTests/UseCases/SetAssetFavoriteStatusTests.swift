import Testing

@testable import Domain

struct SetAssetFavoriteStatusTests {
    
    @Test
    func testAddFavorite() {
        let repository = MockLocalFavoriteRepository()
        let setAssetFavoriteStatus = SetAssetFavoriteStatus(repository: repository).useCase
        
        setAssetFavoriteStatus("asset_123", true)
        
        #expect(repository.added == ["asset_123"])
        #expect(repository.removed.isEmpty)
    }
    
    @Test
    func testRemoveFavorite() {
        let repository = MockLocalFavoriteRepository()
        let setAssetFavoriteStatus = SetAssetFavoriteStatus(repository: repository).useCase
        
        setAssetFavoriteStatus("asset_456", false)
        
        #expect(repository.removed == ["asset_456"])
        #expect(repository.added.isEmpty)
    }
    
}

private final class MockLocalFavoriteRepository: LocalFavoriteRepository {
    
    var added: [String] = []
    var removed: [String] = []
    
    func add(assetID: String) {
        added.append(assetID)
    }
    
    func remove(assetID: String) {
        removed.append(assetID)
    }
    
    func isFavorite(assetID: String) -> Bool {
        added.contains(assetID) && !removed.contains(assetID)
    }
    
    func allFavoriteAssetIDs() -> [String] {
        added.filter { !removed.contains($0) }
    }
}
