import Assets
import DesignTokens
import Domain
import SwiftUI
import UIKit

final class HomeViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let assetsViewController = AssetsFactory.makeAssetsListView()
        assetsViewController.tabBarItem = UITabBarItem(
            title: String(localized: "home.assetsTab.title"),
            image: Icons.assetsTab,
            tag: 0
        )
        let favouritesViewController = AssetsFactory.makeFavoriteAssetsListView()
        favouritesViewController.tabBarItem = UITabBarItem(
            title: String(localized: "home.favoritesTab.title"),
            image: Icons.favoritesTab,
            tag: 1
        )
        
        viewControllers = [
            assetsViewController,
            favouritesViewController
        ]
    }
    
}
