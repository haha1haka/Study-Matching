import Foundation
import RxSwift
import RxCocoa



class MapViewModel: ResultType {
    
    let lat = BehaviorRelay<Double>(value: 37.51818789942772)
    let long = BehaviorRelay<Double>(value: 126.88541765534976)
    var queueSearch = BehaviorRelay<Queue>(value: Queue(fromQueueDB: [], fromQueueDBRequested: [], fromRecommend: []))
    let sesacFriendsArray = BehaviorRelay<[FromQueueDB]>(value: [])

    
    
    func requestQueueSearch(completion: @escaping (Result<String, MemoleaseError>) -> Void) {
                
        MemoleaseService.shared.requestQueueSearch(
            target: MemoleaseRouter.queueSearch(
                lat: lat.value,
                long: long.value)) {
                    
            switch $0 {
            case .success(let queueSearch):
                self.queueSearch.accept(queueSearch)
                self.sesacFriendsArray.accept(queueSearch.fromQueueDB)
                completion(.success(""))
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
