import Foundation

public struct GetAssets {
    
    private let remoteRepository: RemoteAssetRepository
    private let inMemoryRepository: InMemoryAssetRepository
    
    public init(remoteRepository: RemoteAssetRepository, inMemoryRepository: InMemoryAssetRepository) {
        self.remoteRepository = remoteRepository
        self.inMemoryRepository = inMemoryRepository
    }
    
    private func execute(refresh: Bool = false) async throws -> [Asset] {
        
        if !refresh {
            let inMemoryAssets = await inMemoryRepository.getAllAssets()
            
            if !inMemoryAssets.isEmpty {
                return inMemoryAssets
            }
        }
        
        return try await remoteRepository.fetchAllAssets()
    }
}

public extension GetAssets {
    var useCase: UseCase.GetAssets { execute }
}
