import Data
import Domain
import SwiftUI

extension AssetDetailsView {
    
    @MainActor
    final class ViewModel: ObservableObject {
        
        @Published private(set) var state: ViewState<AssetDetailsContent>
        
        private let assetId: String
        private let getAsset: UseCase.GetAsset
        private let isAssetWithIdFavorite: UseCase.IsAssetWithIdFavorite
        private let setFavorite: UseCase.SetAssetFavoriteStatus
        
        init(
            assetId: String,
            getAsset: @escaping UseCase.GetAsset = GetAsset(repository: InMemoryAssetService.shared).useCase,
            isAssetWithIdFavorite: @escaping UseCase.IsAssetWithIdFavorite = IsAssetWithIdFavorite(
                repository: LocalFavoriteService()).useCase,
            setFavorite: @escaping UseCase.SetAssetFavoriteStatus = SetAssetFavoriteStatus(
                repository: LocalFavoriteService()).useCase,
            initialState: ViewState<AssetDetailsContent> = .loading
            )
        {
            self.assetId = assetId
            self.getAsset = getAsset
            self.isAssetWithIdFavorite = isAssetWithIdFavorite
            self.setFavorite = setFavorite
            self.state = initialState
        }
        
        func onAppear() async throws {
            let asset = try await getAsset(assetId)
            renderAsset(asset)
        }
        
        func toggleFavorite() {
            
            if case let .loaded(assetDetailsContent) = state {
                setFavorite(assetId, !assetDetailsContent.isFavorite)
                state = .loaded(assetDetailsContent.toggledFavorite())
            }
        }
        
        private func renderAsset(_ asset: Asset) {
            
            let assetDetailsContent = AssetsRenderer.renderToAssetDetails(asset, isFavorite: isAssetWithIdFavorite(asset.id))
            state = .loaded(assetDetailsContent)
        }
    }
    
    struct AssetDetailsContent {
        
        let name: String
        let symbol: String
        let marketCap: String
        let price: String
        let isFavorite: Bool
        
        func toggledFavorite() -> Self {
            .init(
                name: name,
                symbol: symbol,
                marketCap: marketCap,
                price: price,
                isFavorite: !isFavorite
            )
        }
    }
}
