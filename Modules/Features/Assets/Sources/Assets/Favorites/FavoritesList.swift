import Domain
import SwiftUI

struct FavoritesList: View {
    
    private enum Strings {
        static let title = String(localized: "favoritesList.title", bundle: .main)
    }
    
    @StateObject private var viewModel: ViewModel
    
    init(viewModel: ViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationView {
            StatefulView(state: viewModel.state, content: favoritesList)
            .listStyle(.plain)
            .navigationTitle(Strings.title)
        }
        .navigationViewStyle(.stack)
        .task  { try? await viewModel.onAppear() }
    }
    
    private func favoritesList(_ state: [FavoritesListItem.State]) -> some View {
        List(state) { itemState in
            FavoritesListItem(state: itemState)
        }
    }
}

#Preview {
    
    let getFavorites: UseCase.GetFavorites = { _ in Array(Asset.mockAssets.prefix(3))
    }
    let viewModel = FavoritesList.ViewModel(getFavorites: getFavorites)
    FavoritesList(viewModel: viewModel)
}
