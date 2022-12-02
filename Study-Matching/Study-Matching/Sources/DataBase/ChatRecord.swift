import Foundation
import RealmSwift

class ChatRecord: Object {
    
    @Persisted var to: String
    @Persisted var from: String
    @Persisted var chat: String
    @Persisted var createdAt: String
    
    convenience init(to: String, from: String, chat: String, createdAt: String) {
        self.init()
        self.to = to
        self.from = from
        self.chat = chat
        self.createdAt = createdAt
    }
    
}
