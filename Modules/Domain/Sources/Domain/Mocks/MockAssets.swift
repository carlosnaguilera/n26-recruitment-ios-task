#if DEBUG

extension Asset {
    
    public static let mockBitcoin = Asset(
        id: "btc",
        name: "Bitcoin",
        symbol: "BTC",
        priceChange: -2.867438904563889,
        price: 1234.56,
        marketCap: 1_000_000_000
    )
    public static let mockAssets: [Asset] =
    [
        Asset(
            id: "1",
            name: "Bitcoin",
            symbol: "BTC",
            priceChange: 3.5,
            price: 50000,
            marketCap: 900000000000),
        Asset(
            id: "2",
            name: "Ethereum",
            symbol: "ETH",
            priceChange: 2.1,
            price: 3500,
            marketCap: 400000000000),
        Asset(
            id: "3",
            name: "Ripple",
            symbol: "XRP",
            priceChange: -0.8,
            price: 1.25,
            marketCap: 60000000000),
        Asset(
            id: "4",
            name: "Cardano",
            symbol: "ADA",
            priceChange: 0.5,
            price: 1.75,
            marketCap: 60000000000),
        Asset(
            id: "5",
            name: "Polkadot",
            symbol: "DOT",
            priceChange: 5.6,
            price: 25,
            marketCap: 25000000000),
        Asset(
            id: "6",
            name: "Litecoin",
            symbol: "LTC",
            priceChange: -2.2,
            price: 200,
            marketCap: 12000000000),
        Asset(
            id: "7",
            name: "Dogecoin",
            symbol: "DOGE",
            priceChange: 8.4,
            price: 0.3,
            marketCap: 40000000000),
        Asset(
            id: "8",
            name: "Chainlink",
            symbol: "LINK",
            priceChange: 3.2,
            price: 35,
            marketCap: 15000000000),
        Asset(
            id: "9",
            name: "Solana",
            symbol: "SOL",
            priceChange: -1.3,
            price: 150,
            marketCap: 45000000000),
        Asset(
            id: "10",
            name: "Avalanche",
            symbol: "AVAX",
            priceChange: 4.0,
            price: 90,
            marketCap: 20000000000),
    ]
}
#endif
