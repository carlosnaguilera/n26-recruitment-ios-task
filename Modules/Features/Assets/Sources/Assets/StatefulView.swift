import DesignTokens
import SwiftUI

struct StatefulView<Content, T>: View where Content: View {
    
    private let state: ViewState<T>
    private let retryAction: (() -> Void)?
    private let content: (T) -> Content
    
    @Environment(\.theme) private var theme
    
    init(state: ViewState<T>, retryAction: (() -> Void)? = nil, content: @escaping (T) -> Content) {
        self.state = state
        self.retryAction = retryAction
        self.content = content
    }
    
    var body: some View {
        switch state {
        case .loading:
            ProgressView()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        case .error(let error):
            VStack(spacing: theme.spacing.small300) {
                Text("An error occurred:")
                Text(error.localizedDescription)
                if let retryAction {
                    Button("Retry", action: retryAction)
                }
            }
            .padding()
        case .loaded(let value):
            content(value)
        }
    }
}

#Preview("ViewStateView Previews") {
    
    VStack {
        Text("🔄 Loading")
        StatefulView(state: ViewState<[String]>.loading, retryAction: {}) { items in
            List(items, id: \.self) { Text($0) }
        }

        Text("❌ Error")
        StatefulView(state: ViewState<[String]>.error(NSError(domain: "", code: 0)), retryAction: {}) { items in
            List(items, id: \.self) { Text($0) }
        }

        Text("✅ Loaded")
        StatefulView(state: ViewState.loaded(["One", "Two", "Three"]), retryAction: {}) { items in
            List(items, id: \.self) { Text($0) }
        }
    }
}


