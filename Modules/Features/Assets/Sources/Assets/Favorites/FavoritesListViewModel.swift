import Domain
import SwiftUI

extension FavoritesList {
    
    @MainActor
    final class ViewModel: ObservableObject {
        
        @Published private(set) var state: ViewState<[FavoritesListItem.State]> = .loading
        private let getFavorites: UseCase.GetFavorites
        
        init(getFavorites: @escaping UseCase.GetFavorites) {
            self.getFavorites = getFavorites
        }
        
        func onAppear() async throws {
            
            do {
                let favoriteAssets = try await getFavorites(false)
                let state = favoriteAssets.map { AssetsRenderer.renderToFavoritesListItem($0) }
                updateFavorites(state)
            } catch {
                setErrorState(error)
            }
            
        }
        
        private func updateFavorites(_ state: [FavoritesListItem.State]) {
            self.state = .loaded(state)
        }
        
        private func setErrorState(_ error: Error) {
            state = .error(error)
        }
    }
}
