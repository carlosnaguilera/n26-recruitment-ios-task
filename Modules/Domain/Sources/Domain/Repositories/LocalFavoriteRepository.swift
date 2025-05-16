import Foundation

public protocol LocalFavoriteRepository {
    func add(assetID: String)
    func remove(assetID: String)
    func isFavorite(assetID: String) -> Bool
    func allFavoriteAssetIDs() -> [String]
}
