import Foundation
import RxSwift
import RxCocoa

//
//enum RootView {
//    case empty
//    case exist
//}
//
//extension RootView {
//    var loadView: Bool {
//        switch self {
//        case .empty:
//            return false
//        case .exist:
//            return true
//        }
//    }
//}


class FindViewModel: ResultType {
    
    
    var pageIndex = BehaviorRelay(value: 0)
    
    
    let lat = BehaviorRelay<Double>(value: 37.51818789942772)
    let long = BehaviorRelay<Double>(value: 126.88541765534976)
    var sesacFriendDataStore = BehaviorRelay<Queue>(
        value: Queue(
            fromQueueDB: [],
            fromQueueDBRequested: [],
            fromRecommend: []))
    
    var nick       = BehaviorRelay<String>(value: "")
    var reputation = BehaviorRelay<[Int]>(value: [])
    var studyList  = BehaviorRelay<[String]>(value: [])
    var reviews    = BehaviorRelay<[String]>(value: [])
    var gender     = BehaviorRelay<Int>(value: 0)
    var type       = BehaviorRelay<Int>(value: 0)
    var sesac      = BehaviorRelay<Int>(value: 0)
    var background = BehaviorRelay<Int>(value: 0)
    
    var fromQueueDBisEmpty: Bool {
        return sesacFriendDataStore.value.fromQueueDB.isEmpty // --> ture
    }
    var cardItemList =  BehaviorRelay<[Card]>(value: [])
    
    

}

extension FindViewModel {
    func requestQueueSearch(completion: @escaping (Result<String, MemoleaseError>) -> Void) {
        
        
        MemoleaseService.shared.requestQueueSearch(
            target: QueueRouter.queueSearch(
                lat: lat.value,
                long: long.value)) {
                    
                    switch $0 {
                    case .success(let seacFriendDB):
                        
                        self.sesacFriendDataStore.accept(seacFriendDB)
                        print("successsuccesssuccesssuccesssuccesssuccess")
//                        self.makeData()
                        
                        var arr: [Card] = []
                        for item in seacFriendDB.fromQueueDB {
                            arr.append(Card(nick: item.nick, reputation: item.reputation, studyList: item.studylist, reviews: item.reviews, gender: item.gender, type: item.type, sesac: item.sesac, background: item.background, uid: item.uid))
                        }

                        print("📣📣fromQueueDB📣📣📣\(arr)")
                        self.cardItemList.accept(arr)
                        
                        completion(.success(""))
                        
                        return
                    case .failure(let error):
                        switch error {
                        case .idTokenError:
                            completion(.failure(.idTokenError))
                            return
                        case .unRegistedUser:
                            completion(.failure(.unRegistedUser))
                            return
                        default:
                            return
                        }
                    }
                }
    }
    
    
    
    func requestQueueStop(completion: @escaping (Result<Succeess, MemoleaseError>) -> Void) {
        MemoleaseService.shared.requestQueueStop(target: QueueRouter.queueStop) {
            switch $0 {
            case .success:
                completion(.success(.perfact))
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
    
    
    
    
    func requestStudy(uid: String, completion: @escaping (Result<Succeess, MemoleaseError>) -> Void) {
        MemoleaseService.shared.requestStudy(target: QueueRouter.queueRequest(otheruid: uid)) {
            switch $0 {
            case .success(let success):
                switch success {
                case .perfact:
                    completion(.success(.perfact))
                case .alreadyRequested:
                    completion(.success(.alreadyRequested))
                }
            case .failure(let error):
                switch error {
                case .searchStop:
                    completion(.failure(.searchStop))
                case .idTokenError:
                    completion(.failure(.idTokenError))
                default:
                    return
                }
                
            }
        }
    }
    
    
    
    
    
}
