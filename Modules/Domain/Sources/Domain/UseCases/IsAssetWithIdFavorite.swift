import Foundation

public struct IsAssetWithIdFavorite {
    
    private let repository: LocalFavoriteRepository
    
    public init(repository: LocalFavoriteRepository) {
        self.repository = repository
    }
    
    private func execute(id: String) -> Bool {
        repository.isFavorite(assetID: id)
    }
}

public extension IsAssetWithIdFavorite {
    
    var useCase: UseCase.IsAssetWithIdFavorite { execute }
}
