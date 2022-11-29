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
    var sesacFriendDataStore = BehaviorRelay<Queue>(value: Queue(fromQueueDB: [], fromQueueDBRequested: [], fromRecommend: []))
    
    var nick       = BehaviorRelay<String>(value: "")
    var reputation = BehaviorRelay<[Int]>(value: [])
    var studyList      = BehaviorRelay<[String]>(value: [])
    var reviews    = BehaviorRelay<[String]>(value: [])
    var gender     = BehaviorRelay<Int>(value: 0)
    var type       = BehaviorRelay<Int>(value: 0)
    var sesac      = BehaviorRelay<Int>(value: 0)
    var background = BehaviorRelay<Int>(value: 0)
    
    var fromQueueDBisEmpty: Bool {
        return sesacFriendDataStore.value.fromQueueDB.isEmpty // --> ture
    }
    
    var cardList =  BehaviorRelay<[Card]>(value: [])
    
    
    
    func makeData() {
        var arr: [Card] = []
        sesacFriendDataStore.value.fromQueueDB.forEach {
//            self.nick.accept($0.nick)
//            self.reputation.accept($0.reputation)
//            self.studyList.accept($0.studylist)
//            self.reviews.accept($0.reviews)
//            self.gender.accept($0.gender)
//            self.type.accept($0.type)
            self.sesac.accept($0.sesac)
            self.background.accept($0.background)
            arr.append(Card(nick: $0.nick, reputation: $0.reputation, studyList: $0.studylist, reviews: $0.reviews, gender: $0.gender, type: $0.type, sesac: $0.sesac, background: $0.background))
        }
        cardList.accept(arr)
    }
    
    
    
}

extension FindViewModel {
    func requestQueueSearch(completion: @escaping (Result<String, MemoleaseError>) -> Void) {
        
        MemoleaseService.shared.requestQueueSearch(
            target: MemoleaseRouter.queueSearch(
                lat: lat.value,
                long: long.value)) {
                    
                    switch $0 {
                    case .success(let seacFriendDB):
                        
                        self.sesacFriendDataStore.accept(seacFriendDB)
                        print("successsuccesssuccesssuccesssuccesssuccess")
//                        self.makeData()
                        
                        var arr: [Card] = []
                        for item in seacFriendDB.fromQueueDB {
                            arr.append(Card(nick: item.nick, reputation: item.reputation, studyList: item.studylist, reviews: item.reviews, gender: item.gender, type: item.type, sesac: item.sesac, background: item.background))
                        }
                        self.cardList.accept(arr)
                        
                        print("🚨\(self.cardList.value.forEach{ $0.nick })")
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
}
