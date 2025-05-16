import Data
import DesignTokens
import Domain
import SwiftUI
import UIKit

@MainActor
public protocol AssetsBuilding {
    static func makeAssetsListView() -> UIViewController
}

public struct AssetsFactory: AssetsBuilding {
    
    public static func makeAssetsListView() -> UIViewController {
        let assetsRootView = AssetsList()
            .environment(\.theme, DefaultTheme())
        let viewController = UIHostingController(rootView: assetsRootView)
        return viewController
    }
    
    public static func makeFavoriteAssetsListView() -> UIViewController {
        
        let getAssets: UseCase.GetAssets = GetAssets(
            remoteRepository: RemoteAssetService(),
            inMemoryRepository: InMemoryAssetService()
        ).useCase
        
        let getFavorites: UseCase.GetFavorites = GetFavorites(
            getAssets: getAssets,
            favoriteRepository: LocalFavoriteService()
        ).useCase
        
        let viewModel = FavoritesList.ViewModel(getFavorites: getFavorites)
        
        let view = FavoritesList(viewModel: viewModel)
            .environment(\.theme, DefaultTheme())
        let viewController = UIHostingController(rootView: view
        )
        return viewController
    }
    
    static func makeAssetDetailsView(assetId: String) -> AssetDetailsView {
        
        let viewModel = AssetDetailsView.ViewModel(assetId: assetId)
        return AssetDetailsView(viewModel: viewModel)
    }
}

