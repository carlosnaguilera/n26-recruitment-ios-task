import Foundation

public struct SetAssetFavoriteStatus {
    
    private let repository: LocalFavoriteRepository
    
    public init(repository: LocalFavoriteRepository) {
        self.repository = repository
    }
    
    private func execute(assetId: String, isFavorite: Bool) {
        
        if isFavorite {
            repository.add(assetID: assetId)
        } else {
            repository.remove(assetID: assetId)
        }
    }
}

public extension SetAssetFavoriteStatus {
    
    var useCase: UseCase.SetAssetFavoriteStatus { execute }
}
