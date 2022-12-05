import Foundation
import RealmSwift
import RxSwift
import RxCocoa

class ChatViewModel {
    
    let chatRepository = ChatRepository()

    var chatDataBase: Results<Chat>!
    
    var liveChat = BehaviorRelay<[Chat]>(value: [])
        
    //var dataList: [Chat] = []

    var arr: [Chat] = []
    
    let myUid = UserDefaultsManager.standard.myUid
    

    
    func sendChat(chatText: String, completion: @escaping (Result<Succeess, MemoleaseError>) -> Void) {
        
        let matchedUid = UserDefaultsManager.standard.matchedUid
        
        print("❌❌❌\(matchedUid)")
        
        
        
        MemoleaseService.shared.requestPostChat(target: ChatRouter.chat(id: matchedUid, chatText: chatText)) {
            switch $0 {
            case .success(let chat):
                completion(.success(.perfact))
                
                
                
                self.arr.append(chat)
                self.liveChat.accept(self.arr)
                
                
                self.chatRepository.addChat(item: chat)
                return
            case .failure(let error):
                switch error {
                case .unableChat:
                    // MARK: -해결하기 8
                    completion(.failure(.unableChat))
                    return
                case .idTokenError:
                    completion(.failure(.idTokenError))
                default:
                    return
                }
            }
        }
    }
    
    
    
    
    func checkQueueState(completion: @escaping (Result<QueueState?, MemoleaseError>) -> Void) {
        MemoleaseService.shared.requestQueueState(target: QueueRouter.queueState) {
            switch $0 {
            case .success(let state):
                guard let state = state else { return }
                if state.dodged == 1 || state.reviewed == 1 {
                    completion(.failure(.canceledMatch))
                } else {
                    print("🐸\(UserDefaultsManager.standard.matchedUid)")
                    print("🐸\(UserDefaultsManager.standard.matchedNick)")
                    print("⭐️\(state.matchedUid)")
                    print("⭐️\(state.matchedNick)")
                    UserDefaultsManager.standard.matchedUid = state.matchedUid ?? ""
                    UserDefaultsManager.standard.matchedNick = state.matchedNick ?? ""
                    completion(.success(nil))
                }
                
                return
                
            case .failure(let error):
                switch error {
                case .idTokenError:
                    completion(.failure(.idTokenError))
                default:
                    return
                }
            }
        }
    }
    
    func requestDodge(completion: @escaping (Result<Succeess, MemoleaseError>) -> Void) {
        
        let matchedUid = UserDefaultsManager.standard.matchedUid
        
        MemoleaseService.shared.requestDodge(target: QueueRouter.queuedodge(otheruid: matchedUid)) {
            switch $0 {
            case .success:
                return
            case .failure(let error):
                switch error {
                case .wrongUid:
                    completion(.failure(.wrongUid))
                case .idTokenError:
                    completion(.failure(.idTokenError))
                case .unRegistedUser:
                    completion(.failure(.unRegistedUser))
                default:
                    return
                }
            }
        }
    }
    func fetchLastChat(mathedUid: String, completion: @escaping () -> Void) {
        
    }
    
    
    
    func fetchChat() {
        self.chatDataBase = chatRepository.fetchChat()
    }
    
    
    
    func fetchchatchat() {
        //self.chatchat.value = chatRepository.fetchChat()
        
    }
        
}
