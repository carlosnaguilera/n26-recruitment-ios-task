import SwiftUI

public protocol Colors: Sendable {
    var positive: Color { get }
    var negative: Color { get }
}

public struct DefaultColors: Colors {
    public var positive: Color = .green
    public var negative: Color = .red
    
    public init() {}
}
