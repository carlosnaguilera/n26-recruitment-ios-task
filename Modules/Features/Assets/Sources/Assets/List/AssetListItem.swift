import DesignTokens
import Domain
import SwiftUI

struct AssetListItem: View {
    
    private let state: State
    @Environment(\.theme) private var theme
    
    init(state: State) {
        self.state = state
    }
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: theme.spacing.small100) {
                Text(state.name)
                    .font(.headline)
                
                Text(state.symbol.uppercased())
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: theme.spacing.small100) {
                Text(state.priceChange)
                    .font(.subheadline)
                    .foregroundStyle(state.priceChangeSign == .plus ? theme.colors.positive : theme.colors.negative)
                
                Text(state.price)
                    .font(.subheadline)
                    .foregroundStyle(.primary)
            }
            .padding(.horizontal, theme.spacing.small100)
        }
        .padding(.vertical, theme.spacing.small300)
    }
}

extension AssetListItem {
    
    struct State: Identifiable, Hashable {
        
        let id: String
        let name: String
        let symbol: String
        let priceChange: String
        let price: String
        let priceChangeSign: FloatingPointSign
    }
}

#Preview {
    
    let asset = Asset(
        id: "id",
        name: "Bitcoin",
        symbol: "BTC",
        priceChange: -0.6982242215653566,
        price: 82664.2014369976753946,
        marketCap: 1640645416318.0494963032442114
    )
    let state = AssetsRenderer.renderToAssetsListItem(asset)
    AssetListItem(state: state)
}
