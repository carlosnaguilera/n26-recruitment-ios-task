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
    var priceDouble: Double? {
        priceUsd.flatMap(Double.init)
    }
    var changePercentDouble: Double? {
        changePercent24Hr.flatMap(Double.init)
    }
    var marketCapDouble: Double? {
        marketCapUsd.flatMap(Double.init)
    }
}
