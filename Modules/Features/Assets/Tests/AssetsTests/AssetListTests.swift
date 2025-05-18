import Domain
import SnapshotTesting
import SwiftUI
import Testing

@testable import Assets

@MainActor
struct AssetListTests {
    
    @Test func snapshotView() async throws {
        
        let viewModel = AssetsList.ViewModel(getAssets: { _ in Asset.mockAssets })
        try await viewModel.onAppear()
        let view = AssetsList(viewModel: viewModel)
        
        withSnapshotTesting(record: .never) {
            assertSnapshot(of: view, as: .image(layout: .device(config: .iPhone13)))
        }
    }
}
