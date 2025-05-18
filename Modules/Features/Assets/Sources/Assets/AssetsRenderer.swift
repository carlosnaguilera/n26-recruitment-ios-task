import Domain
import Foundation

struct AssetsRenderer {
    
    static func renderToAssetsListItem(_ asset: Asset, locale: Locale = .current) -> AssetListItem.State {
        
        AssetListItem
            .State(
                id: asset.id,
                name: asset.name,
                symbol: asset.symbol,
                priceChange: (asset.priceChange / 100).formatted(.percent.precision(.fractionLength(2)).locale(locale)),
                price: renderPrice(asset.price, locale: locale),
                priceChangeSign: asset.priceChange.sign
            )
    }
    
    static func renderToFavoritesListItem(_ asset: Asset, locale: Locale = .current) -> FavoritesListItem.State {
        
        FavoritesListItem
            .State(
                id: asset.id,
                name: asset.name,
                symbol: asset.symbol,
                marketCap: renderMarketCap(asset.marketCap, locale: locale),
                price: renderPrice(asset.price, locale: locale)
            )
    }
    
    static func renderToAssetDetails(_ asset: Asset, isFavorite: Bool, locale: Locale = .current) -> AssetDetailsView.AssetDetailsContent {
        
        AssetDetailsView.AssetDetailsContent(
            name: asset.name,
            symbol: asset.symbol,
            marketCap: renderMarketCap(asset.marketCap, locale: locale),
            price: renderPrice(asset.price, locale: locale),
            isFavorite: isFavorite
        )
    }
    
    private static func renderPrice(_ price: Decimal, locale: Locale = .current) -> String {
        price.formatted(.currency(code: "EUR").locale(locale))
    }
    
    private static func renderMarketCap(_ marketCap: Decimal, locale: Locale) -> String {
        if #available(iOS 18, *) {
            return marketCap.formatted(
                .currency(code: "EUR")
                .notation(.compactName)
                .precision(.fractionLength(2))
                .locale(locale)
            )
        } else {
            let formatter = NumberFormatter()
            formatter.numberStyle = .currency
            formatter.currencyCode = "EUR"
            formatter.maximumFractionDigits = 2
            formatter.minimumFractionDigits = 0
            formatter.locale = locale
            
            let billion = Decimal(1_000_000_000)
            let million = Decimal(1_000_000)
            let thousand = Decimal(1_000)
            
            switch marketCap {
            case let x where x >= billion:
                let value = (x / billion) as NSDecimalNumber
                return "\(formatter.string(from: value) ?? "")B"
            case let x where x >= million:
                let value = (x / million) as NSDecimalNumber
                return "\(formatter.string(from: value) ?? "")M"
            case let x where x >= thousand:
                let value = (x / thousand) as NSDecimalNumber
                return "\(formatter.string(from: value) ?? "")K"
            default:
                return formatter.string(from: marketCap as NSDecimalNumber) ?? ""
            }
        }
    }
}
    
