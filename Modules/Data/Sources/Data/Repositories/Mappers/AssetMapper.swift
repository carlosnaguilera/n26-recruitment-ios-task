import Domain
import Foundation

struct AssetMapper {
    
    static func mapToDomain(assetsDataModels: [AssetDataModel], euroRateDataModel: RateDataModel) -> [Asset] {
        
        assetsDataModels.compactMap { mapToDomain(assetDataModel: $0, euroRateDataModel: euroRateDataModel) }
    }
    
    private static func mapToDomain(assetDataModel: AssetDataModel, euroRateDataModel: RateDataModel) -> Asset? {
        
        guard let exchangeRate = euroRateDataModel.rateUsdDouble,
              let priceUsd = assetDataModel.priceDouble,
              let change = assetDataModel.changePercentDouble,
                let marketCap = assetDataModel.marketCapDouble else {
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
