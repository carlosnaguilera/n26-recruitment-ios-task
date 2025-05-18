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
    
    let getFavorites: UseCase.GetFavorites = { _ in
        [
            Asset(
                id: "1",
                name: "Bitcoin",
                symbol: "BTC",
                priceChange: 3.5,
                price: 50000,
                marketCap: 900_000_000_000
            ),
            Asset(
                id: "2",
                name: "Ethereum",
                symbol: "ETH",
                priceChange: 2.1,
                price: 3500,
                marketCap: 400_000_000_000
            ),
        ]
    }
    let viewModel = FavoritesList.ViewModel(getFavorites: getFavorites)
    FavoritesList(viewModel: viewModel)
}
