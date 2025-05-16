import Foundation

public protocol CornerRadius: Sendable {
    var medium: CGFloat { get }
}

public struct DefaultCornerRadius: CornerRadius {
    public var medium: CGFloat { 8 }
    
    public init() {}
}
