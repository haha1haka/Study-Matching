import Foundation
import CoreLocation
import RxSwift
import RxCocoa

class MapViewModel: ResultType {
    
    let lat = BehaviorRelay<Double>(value: 37.51818789942772)
    let long = BehaviorRelay<Double>(value: 126.88541765534976)
    let sesacFriendsList = BehaviorRelay<[FromQueueDB]>(value: [])
    var currentLocation = CLLocationCoordinate2D(latitude: 0, longitude: 0)
    var sesacFriendsDataStore = BehaviorRelay<Queue>(
        value: Queue(
            fromQueueDB: [],
            fromQueueDBRequested: [],
            fromRecommend: []))
}

extension MapViewModel {
    func requestQueueSearch(completion: @escaping (Result<Succeess, MemoleaseError>) -> Void) {
        
        MemoleaseService.shared.requestQueueSearch(
            target: QueueRouter.queueSearch(
                lat: lat.value,
                long: long.value)) {
                    
                    switch $0 {
                    case .success(let queueSearch):
                        self.sesacFriendsDataStore.accept(queueSearch)
                        
                        let list: [FromQueueDB] = queueSearch.fromQueueDB + queueSearch.fromQueueDBRequested
                        self.sesacFriendsList.accept(list)
                        
                        completion(.success(.perfact))
                        
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
    
    func checkQueueState(completion: @escaping (Result<QueueState?, MemoleaseError>) -> Void) {
        MemoleaseService.shared.requestQueueState(target: QueueRouter.queueState) {
            switch $0 {
            case .success:

                completion(.success(nil))
                return
                
            case .failure(let error):
                switch error {
                case .defaultState:
                    completion(.failure(.defaultState))
                    return
                case .idTokenError:
                    completion(.failure(.idTokenError))
                default:
                    return
                }
            }
        }
    }
}
