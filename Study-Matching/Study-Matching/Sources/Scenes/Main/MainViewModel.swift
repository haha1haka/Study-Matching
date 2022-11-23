import Foundation
import RxSwift
import RxCocoa

class MainViewModel: ResultType {
    
    static let shared = MainViewModel()
    
    private init() {}
    
    let lat = BehaviorRelay<Double>(value: 37.4827333667903865)
    let long = BehaviorRelay<Double>(value: 126.92983890550006)
    let queue = BehaviorRelay<MemoleaseQueue>(value: MemoleaseQueue(fromQueueDB: [], fromQueueDBRequested: [], fromRecommend: []))


    func requestQueueSearch(lat: Double, long: Double, completion: @escaping MemoleaseQueueSearchPostResult) {
        
        let target = MemoleaseRouter.queue(lat: lat, long: long)
        
        MemoleaseService.shared.requestQueue(
            path      : target.path,
            queryItems: target.queryItems,
            httpMethod: target.httpMethod,
            headers   : target.headers) { [weak self] result in
                guard let self = self else { return }
            switch result {
            case .success(let queueSearch):
                self.queue.accept(queueSearch)
            case .failure:
                print()
            }
        }
        
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
    

    
}
