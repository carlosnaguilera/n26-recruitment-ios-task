import Foundation

public struct Asset: Sendable, Identifiable, Equatable {
    
    public let id: String
    public let name: String
    public let symbol: String
    public let priceChange: Double
    public let price: Double
    public let marketCap: Double
    
    public init(
        id: String,
        name: String,
        symbol: String,
        priceChange: Double,
        price: Double,
        marketCap: Double
    ) {
        self.id = id
        self.name = name
        self.symbol = symbol
        self.priceChange = priceChange
        self.price = price
        self.marketCap = marketCap
    }
}
