import Foundation

struct QueueState: Decodable {
    let dodged     : Int
    let matched    : Int
    let reviewed   : Int
    let matchedNick: String?
    let matchedUid : String?
}

