import Foundation
import RxSwift
import RxCocoa

class WishListViewModel: ResultType {
    
    let lat = BehaviorRelay<Double>(value: 37.51818789942772)
    let long = BehaviorRelay<Double>(value: 126.88541765534976)
    let nearbyStudyList = PublishSubject<[Nearby]>()
    var wantedStudyList = BehaviorRelay<[Wanted]>(value: [])
    
    var sesacFriendDataStore = BehaviorRelay<Queue>(
        value: Queue(fromQueueDB: [], fromQueueDBRequested: [], fromRecommend: []))
    
    var recomandStudyList: [String] {
        return sesacFriendDataStore.value.fromRecommend
    }
    
    var friendsStudyList: [String] {
        return sesacFriendDataStore.value.fromQueueDB
            .map{$0.studylist}
            .flatMap{$0}
    }
    var requestedStudyList: [String] {
        return sesacFriendDataStore.value.fromQueueDBRequested
            .map{$0.studylist}
            .flatMap{$0}
    }
        
    var wantedStudyDataStore: [String] = [] {
        didSet {
            print("🙀\(wantedStudyDataStore)")
            wantedStudyList.accept(cleanedStudyList)
        }
    }
    
    var cleanedStudyList: [Wanted] {
        var arr: [Wanted] = []
        wantedStudyDataStore.forEach { arr.append(Wanted(label: $0)) }
        return arr
    }
}


extension WishListViewModel {
    func requestQueueSearch(completion: @escaping MemoleaseQueueSearchPostResult) {
                
        MemoleaseService.shared.requestQueueSearch(
            target: QueueRouter.queueSearch(
                lat: lat.value,
                long: long.value)) {
                    
            switch $0 {
            case .success(let seacFriendDB):
                self.sesacFriendDataStore.accept(seacFriendDB)
                self.makeData()
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
    
    func requestQueue(completion: @escaping (Result<Succeess, MemoleaseError>) -> Void) {
        
        MemoleaseService.shared.requestGetQueue(target: QueueRouter.queue(lat: lat.value, long: long.value, studylist: {
            if wantedStudyDataStore.isEmpty {
                return ["anything"]
            } else {
                return wantedStudyDataStore
            }
        }())) {
                
            switch $0 {
            case .success:
                completion(.success(.perfact))
            case .failure(let error):
                switch error {
                case .unavailable:
                    completion(.failure(.unavailable))
                case .penalty1:
                    completion(.failure(.penalty1))
                case .penalty2:
                    completion(.failure(.penalty2))
                case .penalty3:
                    completion(.failure(.penalty3))
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

    func makeData() {
        var nearbyStudyList1: [Nearby] = []
        var nearbyStudyList2: [Nearby] = []
        var overlapStudyList: [String] = []

        recomandStudyList.forEach {
            overlapStudyList.append($0)
            nearbyStudyList1.append(Nearby(label: $0, titleColor: SeSacColor.error))
        }
        
        friendsStudyList.forEach {
            overlapStudyList.append($0)
        }
        
        requestedStudyList.forEach {
            overlapStudyList.append($0)
        }
        
        let makeCleanStudyList = Set(overlapStudyList)
        let cleanedStudyList = Array(makeCleanStudyList)
                                
    A: for i in 0..<cleanedStudyList.count {
            for _ in 0..<recomandStudyList.count {
                if !recomandStudyList.contains(cleanedStudyList[i]) {
                    nearbyStudyList2.append(Nearby(label: cleanedStudyList[i]))
                    continue A
                }
            }
        }
        nearbyStudyList.onNext(nearbyStudyList1 + nearbyStudyList2)
    }
}
    
    
