import Foundation

public enum UseCase {}

public extension UseCase {
    
    typealias GetAssets = (_ refresh: Bool) async throws -> [Asset]
    typealias GetAsset = (_ id: String) async throws -> Asset
    typealias IsAssetWithIdFavorite = (_ id: String) -> Bool
    typealias SetAssetFavoriteStatus = (_ id: String, _ isFavorite: Bool) -> Void
    typealias GetFavorites = (_ refresh: Bool) async throws -> [Asset]
}
