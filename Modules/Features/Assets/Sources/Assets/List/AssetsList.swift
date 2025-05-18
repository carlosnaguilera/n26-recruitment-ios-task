import Domain
import SwiftUI

public struct AssetsList: View {
    
    private enum Strings {
        static let title = String(localized: "assetsList.title", bundle: .main)
        static let bestOption = String(localized: "assetList.picker.bestOption", bundle: .main)
        static let worstOption = String(localized: "assetList.picker.worstOption", bundle: .main)
    }
    
    @StateObject private var viewModel: ViewModel
    
    init(viewModel: ViewModel) {
        _viewModel = .init(wrappedValue: viewModel)
    }
    
    public var body: some View {
        NavigationView {
            StatefulView(state: viewModel.state,
                         retryAction: { Task { try? await viewModel.onAppear() } },
                         content: assetsList)
            .listStyle(.plain)
            .navigationTitle(Strings.title)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) { performancePicker }
            }
        }
        .task {
            try? await viewModel.onAppear()
        }
    }
    
    private func assetsList(_ state: [AssetListItem.State]) -> some View {
        List(state) { itemState in
            NavigationLink(destination: AssetsFactory.makeAssetDetailsView(assetId: itemState.id)) {
                AssetListItem(state: itemState)
            }
        }
        .animation(.default, value: viewModel.showBest)
    }
    
    private var performancePicker: some View {
        Picker("Performance", selection: $viewModel.showBest) {
            Text(Strings.bestOption).tag(true)
            Text(Strings.worstOption).tag(false)
        }
        .padding()
    }
}

#Preview {
    let getAssets: UseCase.GetAssets = { _ in
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
            Asset(
                id: "3",
                name: "Ripple",
                symbol: "XRP",
                priceChange: -1.2,
                price: 1.2,
                marketCap: 50_000_000_000
            )
        ]
    }
    AssetsList(viewModel: AssetsList.ViewModel(getAssets: getAssets))
}
