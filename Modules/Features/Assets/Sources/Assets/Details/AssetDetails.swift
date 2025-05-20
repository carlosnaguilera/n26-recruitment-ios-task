import DesignTokens
import Domain
import SwiftUI

struct AssetDetailsView: View {
    
    private enum Strings {
        static let title = String(localized: "assetDetails.title", bundle: .main)
        static let favoriteButton = String(localized: "assetDetails.favoriteButton", bundle: .main)
        static let unfavoriteButton = String(localized: "assetDetails.unfavoriteButton", bundle: .main)
    }
    
    @StateObject private var viewModel: ViewModel
    @Environment(\.theme) private var theme
    
    init(viewModel: ViewModel) {
        _viewModel = .init(wrappedValue: viewModel)
    }
    
    var body: some View {
        StatefulView(state: viewModel.state, content: mainContent)
        .navigationTitle(Self.Strings.title)
        .navigationBarTitleDisplayMode(.inline)
        .task {
            try? await viewModel.onAppear()
        }
    }
    
    private func mainContent(_ state: AssetDetailsContent) -> some View {
        
        VStack {
            Text(state.name)
                .font(.largeTitle)
                .padding(.top)
            Text(state.symbol)
                .font(.title2)
                .padding(.top)
            
            Text(state.price)
                .padding()
            
            Text(state.marketCap)
                .padding()
            
            Button(action: viewModel.toggleFavorite) {
                Text(state.isFavorite ? Self.Strings.unfavoriteButton : Self.Strings.favoriteButton)
                    .foregroundColor(.white)
                    .padding()
                    .background(state.isFavorite ? theme.colors.negative : theme.colors.positive)
                    .cornerRadius(theme.cornerRadius.medium)
            }
            .padding(.top)
        }
    }
}

#Preview {
    let getAsset: UseCase.GetAsset = { _ in
        Asset(
            id: "1",
            name: "Bitcoin",
            symbol: "BTC",
            priceChange: 3.5,
            price: 50000,
            marketCap: 900_000_000_000
        )}
    let isFavorite: UseCase.IsAssetWithIdFavorite = { _ in false }
    let setFavorite: UseCase.SetAssetFavoriteStatus = { _, _ in }
    let viewModel = AssetDetailsView.ViewModel(
        assetId: "1",
        getAsset: getAsset,
        isAssetWithIdFavorite: isFavorite,
        setFavorite: setFavorite
    )
    AssetDetailsView(viewModel: viewModel)
}
