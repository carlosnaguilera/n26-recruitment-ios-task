import Domain
import Foundation

public final class LocalFavoriteService: LocalFavoriteRepository {
    
    private static let favoritesKey = "favoriteAssetIDs"
    private let userDefaults: UserDefaults
    private var currentFavorites: Set<String> {
        Set(userDefaults.stringArray(forKey: Self.favoritesKey) ?? [])
    }
    
    public init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
    }
    
    public func add(assetID: String) {
        var ids = currentFavorites
        ids.insert(assetID)
        save(ids)
    }
    
    public func remove(assetID: String) {
        var ids = currentFavorites
        ids.remove(assetID)
        save(ids)
    }
    
    public func isFavorite(assetID: String) -> Bool {
        let ids = currentFavorites
        return ids.contains(assetID)
    }
    
    public func allFavoriteAssetIDs() -> [String] {
        userDefaults.stringArray(forKey: Self.favoritesKey) ?? []
    }
    
    private func save(_ ids: Set<String>) {
        userDefaults.set(Array(ids), forKey: Self.favoritesKey)
    }
}
