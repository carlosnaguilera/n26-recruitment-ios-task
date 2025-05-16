import Foundation

public struct GetAsset {
    
    private let repository: InMemoryAssetRepository
    
    public init(repository: InMemoryAssetRepository) {
        self.repository = repository
    }
    
    private func execute(id: String) async throws -> Asset {
        try await repository.getAsset(id: id)
    }
}

public extension GetAsset {
    
    var useCase: UseCase.GetAsset { execute }
}
