import Domain
import Foundation
import Testing

@testable import Assets

struct AssetsRendererTests {
    @Test
    func formatsCorrectlyInEnglishUSLocale() throws {
        
        let locale = Locale(identifier: "en_US")

        let state = AssetsRenderer.renderToAssetsListItem(Asset.mockBitcoin, locale: locale)

        #expect(state.name == "Bitcoin")
        #expect(state.symbol == "BTC")
        #expect(state.priceChange == "-2.87%")
        #expect(state.price == "€1,234.56")
        #expect(state.priceChangeSign == .minus)
    }

    @Test
    func formatsCorrectlyInSpanishLocale() throws {
        
        let locale = Locale(identifier: "es_ES")

        let viewModel = AssetsRenderer.renderToAssetsListItem(Asset.mockBitcoin, locale: locale)

        #expect(viewModel.priceChange == "-2,87 %")
        #expect(viewModel.price == "1234,56 €")
        #expect(viewModel.priceChangeSign == .minus)
    }
    
    @Test
    func assetDetailsRendersCorrectly() {
        
        let locale = Locale(identifier: "en_US")
        
        let details = AssetsRenderer.renderToAssetDetails(Asset.mockBitcoin, isFavorite: true, locale: locale)
        print(details)
        #expect(details.name == "Bitcoin")
        #expect(details.symbol == "BTC")
        #expect(details.marketCap == "€1.00B")
        #expect(details.price == "€1,234.56")
        #expect(details.isFavorite == true)
    }
    
    @Test
    func renderMarketCapHandlesAllRanges() {
        let locale = Locale(identifier: "en_US")
        
        // Billion
        let assetB = Asset(id: "b", name: "Billion", symbol: "B", priceChange: 0, price: 0, marketCap: 1_000_000_000)
        let billionCap = AssetsRenderer.renderToFavoritesListItem(assetB, locale: locale).marketCap
        #expect(billionCap.contains("B"))
        
        // Million
        let assetM = Asset(id: "m", name: "Million", symbol: "M", priceChange: 0, price: 0, marketCap: 2_000_000)
        let millionCap = AssetsRenderer.renderToFavoritesListItem(assetM, locale: locale).marketCap
        #expect(millionCap.contains("M"))
        
        // Thousand
        let assetK = Asset(id: "k", name: "Thousand", symbol: "K", priceChange: 0, price: 0, marketCap: 5_000)
        let thousandCap = AssetsRenderer.renderToFavoritesListItem(assetK, locale: locale).marketCap
        #expect(thousandCap.contains("K"))
        
        // Default (no suffix)
        let assetS = Asset(id: "s", name: "Small", symbol: "S", priceChange: 0, price: 0, marketCap: 500)
        let smallCap = AssetsRenderer.renderToFavoritesListItem(assetS, locale: locale).marketCap
        #expect(!smallCap.contains("K") && !smallCap.contains("M") && !smallCap.contains("B"))
    }
}

