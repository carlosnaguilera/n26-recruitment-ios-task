import SwiftUI

struct FavoritesList: View {
    
    private enum Strings {
        static let title = String(localized: "favoritesList.title", bundle: .main)
    }
    
    @StateObject private var viewModel: ViewModel
    
    public init(viewModel: ViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationStack {
            StatefulView(state: viewModel.state, content: favoritesList)
            .listStyle(.plain)
            .navigationTitle(Strings.title)
        }
        .task  { try? await viewModel.onAppear() }
    }
    
    private func favoritesList(_ state: [FavoritesListItem.State]) -> some View {
        List(state) { itemState in
            FavoritesListItem(state: itemState)
        }
    }
}
