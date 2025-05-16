import Domain
import SwiftUI

public struct AssetsList: View {
    
    private enum Strings {
        static let title = String(localized: "assetsList.title", bundle: .main)
        static let bestOption = String(localized: "assetList.picker.bestOption", bundle: .main)
        static let worstOption = String(localized: "assetList.picker.worstOption", bundle: .main)
    }
    
    @StateObject private var viewModel: ViewModel
    
    public init() {
        _viewModel = StateObject(wrappedValue: ViewModel())
    }
    
    init(viewModel: ViewModel) {
        _viewModel = .init(wrappedValue: viewModel)
    }
    
    public var body: some View {
        NavigationStack {
            StatefulView(state: viewModel.state,
                         retryAction: { Task { try? await viewModel.onAppear() } },
                         content: assetsList)
            .navigationDestination(for: AssetListItem.State.self) { selection in
                AssetsFactory.makeAssetDetailsView(assetId: selection.id)
            }
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
            NavigationLink(value: itemState) {
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
    AssetsList()
}
