import Foundation
import RealmSwift
import RxSwift
import RxCocoa

class ChatViewModel {
    
    let chatRepository = RMChatRepository()
    
    
    //var liveChat2 = BehaviorRelay<[Chat]>(value: [])
    var chatDataBase: Results<RMChat>!
    
    let myUid = UserDefaultsManager.standard.myUid
    
    
//    var otherChat = BehaviorRelay<[Left]>(value: [])
//
//    var myChat = BehaviorRelay<[Right]>(value: [])
//    var chatItme = BehaviorRelay<[ChatItem]>(value: [])
    
    func sendChat(chatText: String, completion: @escaping (Result<Succeess, MemoleaseError>) -> Void) {
        
        let matchedUid = UserDefaultsManager.standard.matchedUid
        
        print("❌\(matchedUid)")
        
        MemoleaseService.shared.requestPostChat(target: ChatRouter.chat(id: matchedUid, chatText: chatText)) {
            switch $0 {
            case .success( _):
                completion(.success(.perfact))
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
                    UserDefaultsManager.standard.matchedUid = state.matchedUid ?? "없음"
                    UserDefaultsManager.standard.matchedNick = state.matchedNick ?? "없음"
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
    
    
//    func fetchLastChat() {
//
//        chatDataBase = chatRepository.fetchChat()
//
//        var leftChatList: [Left] = []
//        var rightChatList: [Right] = []
//
//        for i in chatDataBase {
//            if i.from == myUid {
//                rightChatList.append(Right(text: i.chat, createdAt: i.createdAt))
//            } else {
//                leftChatList.append(Left(text: i.chat, createdAt: i.chat))
//            }
//
//        }
//        chatItme.accept(chatItme.map(rightChatList))
//        otherChat.accept(leftChatList)
//
//    }
}
