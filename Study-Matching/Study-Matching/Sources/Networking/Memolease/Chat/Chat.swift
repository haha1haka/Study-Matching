import Foundation

struct Chat: Codable {
    let id: String
    let to: String
    let from: String
    let chat: String
    let createdAt: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case to, from, chat, createdAt
    }
}
