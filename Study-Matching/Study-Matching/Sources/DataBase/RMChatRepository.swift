import Foundation
import RealmSwift


protocol ChatDataBaseRepository {
    func addChat(item: RMChat)
    func fetchChat() -> Results<RMChat>
}


final class RMChatRepository: ChatDataBaseRepository {
    
    let database = try! Realm()
    
    
    func addChat(item: RMChat) {
        do {
            try database.write {
                database.add(item)
            }
        } catch let error {
            print("Create error: \(error)")
        }
    }


    func fetchChat() -> Results<RMChat> {
        return database.objects(RMChat.self)
    }

}
