import Foundation

struct Launch: Decodable {
    let success: Bool?
    let rocket: String
    let name: String
    let dateUtc: Date
}
