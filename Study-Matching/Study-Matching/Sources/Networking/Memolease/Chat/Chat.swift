import Foundation
import RealmSwift

class Chat: Object, Codable {
    
    @Persisted var id: String
    @Persisted var from: String
    @Persisted var to: String
    @Persisted var chat: String
    @Persisted var createdAt: String

    
    convenience init(id: String, from: String, to: String, chat: String, createdAt: String) {
        self.init()
        self.id = id
        self.from = from
        self.to = to
        self.chat = chat
        self.createdAt = createdAt
    }
    
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case to, from, chat, createdAt
    }
}


