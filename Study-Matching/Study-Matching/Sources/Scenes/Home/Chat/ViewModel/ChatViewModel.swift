import Foundation
import RealmSwift
import RxSwift
import RxCocoa

class ChatViewModel {
    
    let chatRepository = ChatRepository()
    var chatDataBase: Results<Chat>!
    var payloadChat = PublishRelay<[Chat]>()
    var liveChat = BehaviorRelay<[Chat]>(value: [])
    var arr: [Chat] = []
    var dateString = ""
    let myUid = UserDefaultsManager.standard.myUid
    
    func sendChat(chatText: String, completion: @escaping (Result<Succeess, MemoleaseError>) -> Void) {
    
        let matchedUid = UserDefaultsManager.standard.matchedUid

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
    

    func fetchLastChat(completion: @escaping (Result<Succeess, MemoleaseError>) -> Void) {
        
        let matchedUid = UserDefaultsManager.standard.matchedUid

        if let lastData = chatDataBase.last {
            dateString = lastData.createdAt
        } else {
            dateString = "2000-01-01T00:00:00.000Z"
        }
        
        MemoleaseService.shared.requestGetLastChat(target: ChatRouter.chatLast(otheruid: matchedUid, lastchatDate: self.dateString)) {
            switch $0 {
            case .success(let lastChat):
                print("🟨🟨🟨🟨\(lastChat)")
                self.payloadChat.accept(lastChat.payload)
                completion(.success(.perfact))
                return
            case .failure(let error):
                switch error {
                case .idTokenError:
                    completion(.failure(.idTokenError))
                    print("fasdfsadfads")
                case .unRegistedUser:
                    print("등록 되지 않는 사용자 입니다.")
                default:
                    return
                }
            }
        }
    }
    
    func fetchRealmChat(completion: @escaping () -> Void) {
        self.chatDataBase = chatRepository.fetchChat()
        completion()
    }
}

