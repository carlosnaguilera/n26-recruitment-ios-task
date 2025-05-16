import Foundation
import SwiftUI

public protocol Theme: Sendable {
    var spacing: Spacing { get }
    var cornerRadius: CornerRadius { get }
    var colors: Colors { get }
}

public struct DefaultTheme: Theme {
    
    public let spacing: Spacing
    public let cornerRadius: CornerRadius
    public let colors: Colors
    
    public init(spacing: Spacing = DefaultSpacing(),
                cornerRadius: CornerRadius = DefaultCornerRadius(),
                colors: Colors = DefaultColors()) {
        self.spacing = spacing
        self.cornerRadius = cornerRadius
        self.colors = colors
    }
}

private struct ThemeKey: EnvironmentKey {
    static let defaultValue: Theme = DefaultTheme()
}

extension EnvironmentValues {
    public var theme: Theme {
        get { self[ThemeKey.self] }
        set { self[ThemeKey.self] = newValue }
    }
}
