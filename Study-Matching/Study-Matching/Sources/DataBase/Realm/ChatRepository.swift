import Foundation
import RealmSwift


protocol ChatDataBaseRepository {
    func addChat(item: Chat)
    func fetchChat() -> Results<Chat>
}


final class ChatRepository: ChatDataBaseRepository {
    
    let database = try! Realm()
    
    
    func addChat(item: Chat) {
        do {
            try database.write {
                database.add(item)
            }
        } catch let error {
            print("Create error: \(error)")
        }
    }


    func fetchChat() -> Results<Chat> {
        print("🟩\(String(describing: database.configuration.fileURL!))")
        return database.objects(Chat.self)
    }

}
