import Foundation

struct APIListResponse<T: Decodable>: Decodable {
    let data: [T]
    let timestamp: TimeInterval
}
