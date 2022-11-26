import Foundation
import RxSwift
import RxCocoa

class SearchViewModel: ResultType {
    
    let lat = BehaviorRelay<Double>(value: 37.51818789942772)
    let long = BehaviorRelay<Double>(value: 126.88541765534976)
    
    var sesacFriendDataStore = BehaviorRelay<MemoleaseQueue>(value: MemoleaseQueue(fromQueueDB: [], fromQueueDBRequested: [], fromRecommend: []))
    
    var recomandStudyList: [String] {
        return sesacFriendDataStore.value.fromRecommend
    }
    
    var friendsStudyList: [String] {
        print("💀",sesacFriendDataStore.value.fromQueueDB.map{$0.studylist}.flatMap{$0})
        return sesacFriendDataStore.value.fromQueueDB.map{$0.studylist}.flatMap{$0}
    }
    var requestedStudyList: [String] {
        print("💀",sesacFriendDataStore.value.fromQueueDBRequested.map{$0.studylist}.flatMap{$0})
        return sesacFriendDataStore.value.fromQueueDBRequested.map{$0.studylist}.flatMap{$0}
    }
    
    let nearbyStudyList = PublishSubject<[Nearby]>()
    
    var wantedStudyList = BehaviorRelay<[Wanted]>(value: [])
    
    var wantedStudyDataStore: [String] = [] {
        didSet {
            wantedStudyList.accept(cleanedStudyList)
        }
    }
    
    var cleanedStudyList: [Wanted] {
        var arr: [Wanted] = []
        wantedStudyDataStore.forEach { arr.append(Wanted(label: $0)) }
        return arr
    }

    
    
    let sesacFriendsDBRequested = BehaviorRelay<[FromQueueDB]>(value: [])
    

    


    func requestQueueSearch(completion: @escaping MemoleaseQueueSearchPostResult) {
                
        MemoleaseService.shared.requestQueueSearch(
            target: MemoleaseRouter.queueSearch(
                lat: lat.value,
                long: long.value)) {
                    
            switch $0 {
            case .success(let seacFriendDB):
                
                self.sesacFriendDataStore.accept(seacFriendDB)
            
                self.makeDataStore2()
                
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
        MemoleaseService.shared.requestQueue(target: MemoleaseRouter.queue(lat: "37.51818789942772", long: "126.88541765534976", studylist: ["ㅎㅣㅎㅣ"])) {
            switch $0 {
            case .success:
                return
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
    
    
    //개선 하기 ⚠️
    func makeDataStore2() {
        var nearbyStudyList1: [Nearby] = []
        var nearbyStudyList2: [Nearby] = []
        var overlapStudyList: [String] = []

        recomandStudyList.forEach {
            overlapStudyList.append($0)
            nearbyStudyList1.append(Nearby(label: $0, titleColor: SeSacColor.error))
            print("🥶\($0)")
        }
        
        print("🫡\(overlapStudyList)")
        friendsStudyList.forEach {
            overlapStudyList.append($0)
        }
        print("🫡\(overlapStudyList)")
        
        requestedStudyList.forEach {
            overlapStudyList.append($0)
        }
        print("🫡\(overlapStudyList)")
        
        let makeCleanStudyList = Set(overlapStudyList)
        print("🙀\(overlapStudyList)")
        print("🚀\(makeCleanStudyList)")
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
