import Domain
import Foundation

struct AssetMapper {
    
    static func mapToDomain(assetsDataModels: [AssetDataModel], euroRateDataModel: RateDataModel) -> [Asset] {
        
        assetsDataModels.compactMap { mapToDomain(assetDataModel: $0, euroRateDataModel: euroRateDataModel) }
    }
    
    private static func mapToDomain(assetDataModel: AssetDataModel, euroRateDataModel: RateDataModel) -> Asset? {
        
        guard let exchangeRate = euroRateDataModel.rateUsdDecimal,
              let priceUsd = assetDataModel.priceDecimal,
              let change = assetDataModel.changePercentDecimal,
                let marketCap = assetDataModel.marketCapDecimal else {
                  return nil
              }
        
        return Asset(
            id: assetDataModel.id,
            name: assetDataModel.name,
            symbol: assetDataModel.symbol,
            priceChange: change,
            price: priceUsd / exchangeRate,
            marketCap: marketCap / exchangeRate
        )
    }
}
