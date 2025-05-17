import Testing

@testable import Data

@Suite
struct AssetMapperTests {
    
    private let rateDataModel = RateDataModel(
        id: "euro",
        symbol: "EUR",
        currencySymbol: "€",
        type: "fiat",
        rateUsd: "1.1026878015161958"
    )
    
    @Test
    func mapToDomain_withValidData_returnsAsset() throws {
        let dataModel = AssetDataModel(
            id: "bitcoin",
            rank: "1",
            symbol: "BTC",
            name: "Bitcoin",
            supply: nil,
            maxSupply: nil,
            marketCapUsd: "1200000000.50",
            volumeUsd24Hr: nil,
            priceUsd: "42123.45",
            changePercent24Hr: "-2.56",
            vwap24Hr: nil,
            explorer: nil
        )
        
        let asset = AssetMapper.mapToDomain(assetsDataModels: [dataModel], euroRateDataModel: rateDataModel).first
        
        #expect(asset != nil)
        #expect(asset?.id == "bitcoin")
        #expect(asset?.name == "Bitcoin")
        #expect(asset?.symbol == "BTC")
        #expect(asset?.price == 46449.014472777395)
        #expect(asset?.priceChange == -2.56)
        #expect(asset?.marketCap == 1323225362.3707788)
    }
    
    @Test
    func mapToDomain_withMissingPrice_returnsEmptyArray() throws {
        let invalid = AssetDataModel(
            id: "broken",
            rank: "999",
            symbol: "???",
            name: "MissingCoin",
            supply: "1000",
            maxSupply: "2000",
            marketCapUsd: "10000.00",
            volumeUsd24Hr: "123",
            priceUsd: nil,
            changePercent24Hr: "0.01",
            vwap24Hr: "1.0",
            explorer: "https://example.com"
        )
        
        let result = AssetMapper.mapToDomain(assetsDataModels: [invalid], euroRateDataModel: rateDataModel)
        #expect(result.isEmpty)
    }
    
    @Test
    func mapToDomain_withPartialValidList_returnsOnlyValidAssets() throws {
        let valid = AssetDataModel(
            id: "solana",
            rank: "8",
            symbol: "SOL",
            name: "Solana",
            supply: nil,
            maxSupply: nil,
            marketCapUsd: "250000000",
            volumeUsd24Hr: nil,
            priceUsd: "138.25",
            changePercent24Hr: "3.14",
            vwap24Hr: nil,
            explorer: nil
        )
        
        let invalid = AssetDataModel(
            id: "broken",
            rank: "999",
            symbol: "???",
            name: "MissingCoin",
            supply: nil,
            maxSupply: nil,
            marketCapUsd: nil,
            volumeUsd24Hr: nil,
            priceUsd: nil,
            changePercent24Hr: nil,
            vwap24Hr: nil,
            explorer: nil
        )
        
        let result = AssetMapper.mapToDomain(assetsDataModels: [valid, invalid], euroRateDataModel: rateDataModel)
        #expect(result.count == 1)
        #expect(result.first?.id == "solana")
    }
}

