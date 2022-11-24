import Foundation
import RxSwift
import RxCocoa



class HomeViewModel: ResultType {
    
    let lat = BehaviorRelay<Double>(value: 37.4827333667903865)
    let long = BehaviorRelay<Double>(value: 126.92983890550006)
    var queueSearch = BehaviorRelay<MemoleaseQueue>(value: MemoleaseQueue(fromQueueDB: [], fromQueueDBRequested: [], fromRecommend: []))
    let sesacFriendsArray = BehaviorRelay<[FromQueueDB]>(value: [])

    func requestQueueSearch(completion: @escaping MemoleaseQueueSearchPostResult) {
                
        MemoleaseService.shared.requestQueueSearch(
            target: MemoleaseRouter.queueSearch(
                lat: lat.value,
                long: long.value)) {
                    
            switch $0 {
            case .success(let queueSearch):
                self.queueSearch.accept(queueSearch)
                self.sesacFriendsArray.accept(queueSearch.fromQueueDB)
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
}
