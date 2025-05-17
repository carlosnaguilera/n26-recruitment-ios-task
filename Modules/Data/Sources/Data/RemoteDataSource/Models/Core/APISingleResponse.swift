import Foundation

struct APISingleResponse<T: Decodable>: Decodable {
    let data: T
    let timestamp: TimeInterval
}
