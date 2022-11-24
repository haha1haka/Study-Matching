import Foundation
import RxSwift
import RxCocoa

class SearchViewModel: ResultType {
    
    let lat = BehaviorRelay<Double>(value: 37.4827333667903865)
    let long = BehaviorRelay<Double>(value: 126.92983890550006)
    
    var sesacFriendDataStore = BehaviorRelay<MemoleaseQueue>(value: MemoleaseQueue(fromQueueDB: [], fromQueueDBRequested: [], fromRecommend: []))
    
    let nearbyFriendsSearch = PublishSubject<[Nearby]>()
    let sesacFriendsDBRequested = BehaviorRelay<[FromQueueDB]>(value: [])
    

    
    
    
    
    func requestQueueSearch(completion: @escaping MemoleaseQueueSearchPostResult) {
                
        MemoleaseService.shared.requestQueueSearch(
            target: MemoleaseRouter.queueSearch(
                lat: lat.value,
                long: long.value)) {
                    
            switch $0 {
            case .success(let seacFriendDB):
                self.sesacFriendDataStore.accept(seacFriendDB)

                self.makeDataStore()
                return
            case .failure(let error):
                switch error {
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
    
    func makeDataStore() {
        
        var arr: [Nearby] = []
        
        sesacFriendDataStore.value.fromRecommend.forEach {
            arr.append(Nearby(label: $0,titleColor: SeSacColor.error ,borderColor: SeSacColor.error))
        }
        
        sesacFriendDataStore.value.fromQueueDB.forEach {
            $0.studylist.forEach {
                arr.append(Nearby(label: $0))
            }
        }
        
        sesacFriendDataStore.value.fromQueueDBRequested.forEach {
            $0.studylist.forEach {
                arr.append(Nearby(label: $0))
            }
        }
        nearbyFriendsSearch.onNext(arr)
        
    }
    
    
    
}
