import SwiftUI

struct FavoritesListItem: View {
    
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
                Text(state.marketCap)
                    .font(.subheadline)
                
                Text(state.price)
                    .font(.subheadline)
                    .foregroundStyle(.primary)
            }
            .padding(.horizontal, theme.spacing.small100)
        }
        .padding(.vertical, theme.spacing.small300)
    }
}

#Preview {
    
    let state = FavoritesListItem.State(id: "1", name: "Test", symbol: "TST", marketCap: "€132.01b", price: "€0.91")
    FavoritesListItem(state: state)
}

extension FavoritesListItem {
    
    struct State: Identifiable {
        
        let id: String
        let name: String
        let symbol: String
        let marketCap: String
        let price: String
    }
}
