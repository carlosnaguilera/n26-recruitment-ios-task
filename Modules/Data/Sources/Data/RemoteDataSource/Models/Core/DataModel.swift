import Foundation

struct DataModel<T: Decodable>: Decodable {
    let data: T
    let timestamp: TimeInterval
}
