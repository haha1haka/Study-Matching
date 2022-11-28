import Foundation
import RxSwift
import RxCocoa

class NearbyViewModel: ResultType {
    
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
    
    
    
    
    
    func makeData() {
        sesacFriendDataStore.value.fromQueueDB.forEach {
            self.nick.accept($0.nick)
            self.reputation.accept($0.reputation)
            self.studyList.accept($0.studylist)
            self.reviews.accept($0.reviews)
            self.gender.accept($0.gender)
            self.type.accept($0.type)
            self.sesac.accept($0.sesac)
            self.background.accept($0.background)
            
        }
    }
    
    
    
}

extension NearbyViewModel {
    func requestQueueSearch(completion: @escaping (Result<String, MemoleaseError>) -> Void) {
        
        MemoleaseService.shared.requestQueueSearch(
            target: MemoleaseRouter.queueSearch(
                lat: lat.value,
                long: long.value)) {
                    
                    switch $0 {
                    case .success(let seacFriendDB):
                        
                        self.sesacFriendDataStore.accept(seacFriendDB)
                        print("successsuccesssuccesssuccesssuccesssuccess")
                        self.makeData()
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
