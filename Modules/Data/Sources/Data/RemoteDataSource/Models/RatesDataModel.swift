import Foundation

struct RateDataModel: Decodable {
    let id: String
    let symbol: String
    let currencySymbol: String
    let type: String
    let rateUsd: String
}

extension RateDataModel {
    var rateUsdDecimal: Decimal? {
        Decimal.fromPOSIX(rateUsd)
    }
}
