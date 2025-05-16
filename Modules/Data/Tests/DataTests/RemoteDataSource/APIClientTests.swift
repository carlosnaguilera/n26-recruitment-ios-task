import Foundation
import Testing

@testable import Data

struct APIClientTests {

    @Test func testGetAssets_withValidResponse_returnsAssets() async throws {
        
        let client = CoinCapAPIClient(baseURL: "https://api.example.com",
                                      downloader: MockDataDownloader(),
                                      token: "test-token")
        let assets = try await client.getAssets(limit: 1)
        #expect(assets.count == 100)
        #expect(assets[0].id == "bitcoin")
        #expect(assets[0].changePercent24Hr == "-2.0049678709264795")
    }
}
