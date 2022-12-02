import Foundation
import RealmSwift

class RMChat: Object {
    
    @Persisted var from: String
    @Persisted var to: String
    @Persisted var chat: String
    @Persisted var createdAt: String
    
    convenience init(from: String, to: String, chat: String, createdAt: String) {
        self.init()
        self.from = from
        self.to = to
        self.chat = chat
        self.createdAt = createdAt
    }
    
}
