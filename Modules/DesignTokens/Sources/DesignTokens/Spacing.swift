import Foundation

public protocol Spacing: Sendable {
    var small100: CGFloat { get }
    var small200: CGFloat { get }
    var small300: CGFloat { get }
}

public struct DefaultSpacing: Spacing {
    public let small100: CGFloat = 4
    public let small200: CGFloat = 8
    public let small300: CGFloat = 16
    
    public init() {}
}
