import Foundation

public struct GetFavorites {
    
    private let getAssets: UseCase.GetAssets
    private let favoriteRepository: LocalFavoriteRepository

    public init(getAssets: @escaping UseCase.GetAssets, favoriteRepository: LocalFavoriteRepository) {
        self.getAssets = getAssets
        self.favoriteRepository = favoriteRepository
    }
    
    private func execute(refresh: Bool) async throws -> [Asset] {
        
        let favoriteAssetsId = favoriteRepository.allFavoriteAssetIDs()
        let assets = try await getAssets(refresh)
        return favoriteAssetsId.compactMap { favoriteAssetId in
            assets.first { $0.id == favoriteAssetId }
        }
    }
}

public extension GetFavorites {
    var useCase: UseCase.GetFavorites { execute }
}
