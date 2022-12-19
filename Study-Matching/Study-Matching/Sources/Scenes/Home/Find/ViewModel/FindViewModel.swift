import Foundation
import RxSwift
import RxCocoa

class FindViewModel: ResultType {
    
    var pageIndex    = BehaviorRelay(value: 0)
    let lat          = BehaviorRelay<Double>(value: 37.51818789942772)
    let long         = BehaviorRelay<Double>(value: 126.88541765534976)
    var nick         = BehaviorRelay<String>(value: "")
    var reputation   = BehaviorRelay<[Int]>(value: [])
    var studyList    = BehaviorRelay<[String]>(value: [])
    var reviews      = BehaviorRelay<[String]>(value: [])
    var gender       = BehaviorRelay<Int>(value: 0)
    var type         = BehaviorRelay<Int>(value: 0)
    var sesac        = BehaviorRelay<Int>(value: 0)
    var background   = BehaviorRelay<Int>(value: 0)
    var cardItemList =  BehaviorRelay<[Card]>(value: [])
    var timerFlag    = BehaviorRelay<Bool>(value: false)
    var requestedCardItemList =  BehaviorRelay<[Card]>(value: [])

    var sesacFriendDataStore = BehaviorRelay<Queue>(
        value: Queue(
            fromQueueDB: [],
            fromQueueDBRequested: [],
            fromRecommend: []))
    
    var fromQueueDBisEmpty: Bool {
        return sesacFriendDataStore.value.fromQueueDB.isEmpty
    }
    
    var timer: Timer?
}

extension FindViewModel {
    
    func requestQueueSearch(completion: @escaping (Result<String, MemoleaseError>) -> Void) {
            
        MemoleaseService.shared.requestQueueSearch(
            target: QueueRouter.queueSearch(
                lat: lat.value,
                long: long.value)) {
                    
                    switch $0 {
                    case .success(let seacFriendDB):
                        self.sesacFriendDataStore.accept(seacFriendDB)
                        var arr: [Card] = []
                        var requestedArr: [Card] = []
                        for item in seacFriendDB.fromQueueDB {
                            arr.append(Card(nick: item.nick, reputation: item.reputation, studyList: item.studylist, reviews: item.reviews, gender: item.gender, type: item.type, sesac: item.sesac, background: item.background, uid: item.uid))
                        }
                        for item in seacFriendDB.fromQueueDBRequested {
                            requestedArr.append(Card(nick: item.nick, reputation: item.reputation, studyList: item.studylist, reviews: item.reviews, gender: item.gender, type: item.type, sesac: item.sesac, background: item.background, uid: item.uid))
                        }
                        self.cardItemList.accept(arr)
                        self.requestedCardItemList.accept(requestedArr)
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
    
    func requestQueueStop(completion: @escaping (Result<Succeess, MemoleaseError>) -> Void) {
        MemoleaseService.shared.requestQueueStop(target: QueueRouter.queueStop) {
            switch $0 {
            case .success:
                completion(.success(.perfact))
                return
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
    
    func requestStudy(uid: String, completion: @escaping (Result<Succeess, MemoleaseError>) -> Void) {
        MemoleaseService.shared.requestStudy(target: QueueRouter.queueRequest(otheruid: uid)) {
            switch $0 {
            case .success(let success):
                switch success {
                case .perfact:
                    completion(.success(.perfact))
                case .alreadyRequested:
                    completion(.success(.alreadyRequested))
                default:
                    return
                }
            case .failure(let error):
                switch error {
                case .searchStop:
                    completion(.failure(.searchStop))
                case .idTokenError:
                    completion(.failure(.idTokenError))
                default:
                    return
                }
            }
        }
    }
    
    func requestStudyAccept(uid: String, completion: @escaping (Result<Succeess, MemoleaseError>) -> Void) {
        MemoleaseService.shared.requestAccept(target: QueueRouter.queueAccept(otheruid: uid)) {
            switch $0 {
            case .success(let success):
                switch success {
                case .perfact:
                    completion(.success(.perfact))
                case .alreadyMatching:
                    completion(.success(.alreadyMatching))
                case .searchStoping:
                    completion(.success(.searchStoping))
                case .someoneWhoLikesMe:
                    completion(.success(.someoneWhoLikesMe))
                default:
                    return
                }
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
    
    func checkQueueState(completion: @escaping (Result<QueueState?, MemoleaseError>) -> Void) {
        MemoleaseService.shared.requestQueueState(target: QueueRouter.queueState) {
            switch $0 {
            case .success(let state):
                guard let state = state else { return }
                if state.dodged == 1 || state.reviewed == 1 {
                    completion(.failure(.canceledMatch))
                } else {
                    if UserDefaultsManager.standard.matchedState == 1 {
                        self.timerFlag.accept(true)
                        completion(.success(nil))
                    }
                }
                return
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
    
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(ping), userInfo: nil, repeats: true)
    }
    
    @objc func ping() {
        self.checkQueueState { _ in }
    }
    
    func stopTimer() {
        if timer != nil && timer!.isValid {
            timer!.invalidate()
        }
        timer = nil
        self.timerFlag.accept(false)
    }
}
