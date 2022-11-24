import Foundation
import RxSwift
import RxCocoa

//class MainViewModel: ResultType {
//
//    let lat = BehaviorRelay<Double>(value: 37.4827333667903865)
//    let long = BehaviorRelay<Double>(value: 126.92983890550006)
//    var queueSearch = BehaviorRelay<MemoleaseQueue>(value: MemoleaseQueue(fromQueueDB: [], fromQueueDBRequested: [], fromRecommend: []))
//
//
//    func requestQueueSearch(completion: @escaping MemoleaseQueueSearchPostResult) {
//
//        MemoleaseService.shared.requestQueueSearch(target: MemoleaseRouter.queueSearch(lat: lat, long: long)) {
//            switch $0 {
//            case .success(let queueSearch):
//                self.queueSearch.accept(queueSearch)
//            case .failure(let error):
//                switch error {
//                case .idTokenError:
//                    completion(.failure(.idTokenError))
//                case .unRegistedUser:
//                    completion(.failure(.unRegistedUser))
//                default:
//                    return
//                }
//
//
//
//            }
//        }
//
//
//
//    }
//}
