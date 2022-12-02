import Foundation

class ChatViewModel {
    
    
    var chatList: [Chat] = []
    
    func sendChat(uid: String, chatText: String, completion: @escaping (Result<Succeess, MemoleaseError>) -> Void) {
        MemoleaseService.shared.requestPostChat(target: ChatRouter.chat(id: uid, chatText: chatText)) {
            switch $0 {
            case .success(let data):
                let chat = Chat(id: data.id, to: data.to, from: data.from, chat: data.chat, createdAt: data.createdAt)
                self.chatList.append(chat)
                
            case .failure(let error):
                switch error {
                case .unavailable:
                    // MARK: -해결하기 8
                    return
                case .idTokenError:
                    completion(.failure(.idTokenError))
                default:
                    return
                }
                
            }
        }
    }
}
