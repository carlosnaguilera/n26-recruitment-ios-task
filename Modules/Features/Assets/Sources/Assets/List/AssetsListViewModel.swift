import Data
import Domain
import SwiftUI

extension AssetsList {
    
    @MainActor
    final class ViewModel: ObservableObject {
        
        @Published private(set) var state: ViewState<[AssetListItem.State]> = .loading
        @Published var showBest = true {
            didSet {
                filterAssets()
            }
        }
        private let getAssets: UseCase.GetAssets
        private var assets: [Asset] = []
        private var bestAssets: [Asset] = []
        private var worstAssets: [Asset] = []
        
        init(getAssets: @escaping UseCase.GetAssets) {
            self.getAssets = getAssets
        }
        
        func onAppear() async throws {
                                    
            guard assets.isEmpty else { return }
            setLoadingState()
            do {
                assets = try await getAssets(true)
                // Loads and caches assets, preparing both best and worst sorted lists.
                // Ensures it runs only once even if the view appears multiple times.
                let sortedByPriceChange = assets.sorted { $0.priceChange > $1.priceChange }
                
                bestAssets = Array(sortedByPriceChange.prefix(10))
                worstAssets = Array(sortedByPriceChange.suffix(10).reversed())
                filterAssets()
            } catch {
                setErrorState(error)
            }
        }
        
        private func filterAssets() {
            let filteredAssets = showBest ? bestAssets : worstAssets
            let assetsListStates = filteredAssets.map { AssetsRenderer.renderToAssetsListItem($0) }
            state = .loaded(assetsListStates)
        }
        
        private func setErrorState(_ error: Error) {
            state = .error(error)
        }
        
        func setLoadingState() {
            state = .loading
        }
    }
}
