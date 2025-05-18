import Domain
import Foundation
import Testing

@testable import Assets

struct AssetListItemRendererTests {
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
}

