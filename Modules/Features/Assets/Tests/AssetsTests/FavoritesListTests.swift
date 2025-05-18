import Domain
import SnapshotTesting
import SwiftUI
import Testing

@testable import Assets

@MainActor
struct FavoritesListTests {
    
    @Test func snapshotView() async throws {
        
        let viewModel = FavoritesList.ViewModel(getFavorites: { _ in Array(Asset.mockAssets.prefix(5)) })
        try await viewModel.onAppear()
        let view = FavoritesList(viewModel: viewModel)
        
        withSnapshotTesting(record: .never) {
            assertSnapshot(of: view, as: .image(layout: .device(config: .iPhone13)))
        }
    }
}
