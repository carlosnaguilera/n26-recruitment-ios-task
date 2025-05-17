import Foundation

struct ListDataModel<T: Decodable>: Decodable {
    let data: [T]
    let timestamp: TimeInterval
}
