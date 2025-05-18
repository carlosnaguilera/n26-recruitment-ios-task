import Foundation

public struct AssetDataModel: Decodable, Sendable {
    let id: String
    let rank: String
    let symbol: String
    let name: String
    let supply: String?
    let maxSupply: String?
    let marketCapUsd: String?
    let volumeUsd24Hr: String?
    let priceUsd: String?
    let changePercent24Hr: String?
    let vwap24Hr: String?
    let explorer: String?
}

extension AssetDataModel {
    var priceDecimal: Decimal? {
        priceUsd.flatMap(Decimal.fromPOSIX)
    }
    var changePercentDecimal: Decimal? {
        changePercent24Hr.flatMap(Decimal.fromPOSIX)
    }
    var marketCapDecimal: Decimal? {
        marketCapUsd.flatMap(Decimal.fromPOSIX)
    }
}
