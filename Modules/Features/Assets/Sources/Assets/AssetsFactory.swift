import Data
import DesignTokens
import Domain
import SwiftUI
import UIKit

@MainActor
public protocol AssetsBuilding {
    static func makeAssetsListView() -> UIViewController
}

public enum AssetsFactory: AssetsBuilding {
    
    public static func makeAssetsListView() -> UIViewController {
        
        let getAssets = GetAssets(
            remoteRepository: RemoteAssetService(),
            inMemoryRepository: InMemoryAssetService.shared
        ).useCase
        let viewModel = AssetsList.ViewModel(getAssets: getAssets)
        let assetsRootView = AssetsList(viewModel: viewModel)
            .environment(\.theme, DefaultTheme())
        let viewController = UIHostingController(rootView: assetsRootView)
        return viewController
    }
    
    public static func makeFavoriteAssetsListView() -> UIViewController {
        
        let getAssets: UseCase.GetAssets = GetAssets(
            remoteRepository: RemoteAssetService(),
            inMemoryRepository: InMemoryAssetService.shared
        ).useCase
        
        let getFavorites: UseCase.GetFavorites = GetFavorites(
            getAssets: getAssets,
            favoriteRepository: LocalFavoriteService()
        ).useCase
        
        let viewModel = FavoritesList.ViewModel(getFavorites: getFavorites)
        
        let view = FavoritesList(viewModel: viewModel)
            .environment(\.theme, DefaultTheme())
        let viewController = UIHostingController(rootView: view)
        return viewController
    }
    
    static func makeAssetDetailsView(assetId: String) -> AssetDetailsView {
        
        let getAsset = GetAsset(repository: InMemoryAssetService.shared).useCase
        let isAssetWithIdFavorite = IsAssetWithIdFavorite(repository: LocalFavoriteService()).useCase
        let setFavorite = SetAssetFavoriteStatus(repository: LocalFavoriteService()).useCase
        
        let viewModel = AssetDetailsView.ViewModel(
            assetId: assetId,
            getAsset: getAsset,
            isAssetWithIdFavorite: isAssetWithIdFavorite,
            setFavorite: setFavorite
        )
        return AssetDetailsView(viewModel: viewModel)
    }
}

