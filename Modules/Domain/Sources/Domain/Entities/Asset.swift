import Foundation

public struct Asset: Sendable, Identifiable, Equatable {
    
    public let id: String
    public let name: String
    public let symbol: String
    public let priceChange: Decimal
    public let price: Decimal
    public let marketCap: Decimal
    
    public init(
        id: String,
        name: String,
        symbol: String,
        priceChange: Decimal,
        price: Decimal,
        marketCap: Decimal
    ) {
        self.id = id
        self.name = name
        self.symbol = symbol
        self.priceChange = priceChange
        self.price = price
        self.marketCap = marketCap
    }
}
