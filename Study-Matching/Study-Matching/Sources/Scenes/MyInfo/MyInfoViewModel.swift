import Foundation
import RxSwift
import RxCocoa

class MyInfoViewModel: ResultType {
    
    static let shared = MyInfoViewModel()
    
    private init() {}
    
    var background = BehaviorRelay<Int>(value: 0)
    var sesac      = BehaviorRelay<Int>(value: 0)
    var nick       = BehaviorRelay<String>(value: "")
    var reputation = BehaviorRelay<[Int]>(value: [])
    var comment    = BehaviorRelay<[String]>(value: [])
    var gender     = BehaviorRelay<Int>(value: 0)
    var study      = BehaviorRelay<String>(value: "")
    var searchable = BehaviorRelay<Int>(value: 0)
    let age        = BehaviorRelay<[Int]>(value: [])
    var user       = BehaviorRelay<MemoleaseUser?>(value: nil)
    
}

extension MyInfoViewModel {
    
    func fetchUserInfo(completion: @escaping (Result<Succeess, MemoleaseError>) -> Void) {
        
        MemoleaseService.shared.requestGetUser(target: UserRouter.signIn) {
            
            switch $0 {
            case .success(let user):
                self.background.accept(user.background)
                self.sesac.accept(user.sesac)
                self.nick.accept(user.nick)
                self.reputation.accept(user.reputation)
                self.comment.accept(user.comment)
                self.gender.accept(user.gender)
                self.study.accept(user.study)
                self.searchable.accept(user.searchable)
                self.age.accept([user.ageMin,user.ageMax])
                self.user.accept(user)
                completion(.success(.perfact))
            case .failure(let error):
                switch error {
                default:
                    return
                }
            }
        }
    }
}


//    func updateFCMToken(completion: @escaping (Result<Succeess, MemoleaseError>) -> Void) {
//
//        let target = MemoleaseRouter.updateToken(FCMtoken: UserDefaultsManager.standard.FCMToken)
//
//        MemoleaseService.shared.updateFCMToken(
//            path: target.path,
//            queryItems: target.queryItems,
//            httpMethod: target.httpMethod,
//            headers: target.headers) { result in
//
//            switch result {
//            case .success:
//                completion(.success(.perfact))
//            case .failure(let error):
//                switch error {
//                case .idTokenError: //또 재갱신? 무한 츠크요미
//                    return
//                case .unRegistedUser: // 이럴 경우 없음
//                    return
//                case .serverError: // 이럴 경우 없음
//                    return
//                case .clientError:
//                    print("\(error.localizedDescription)")
//                default:
//                    print("\(error.localizedDescription)")
//
//                }
//            }
//        }
//    }
extension MyInfoViewModel {
    func updateUserInfo(completion: @escaping (Result<Succeess, MemoleaseError>) -> Void) {
        
        MemoleaseService.shared.updateUser(
            target:UserRouter.updateUser(
                searchable: searchable.value,
                ageMin: age.value[0],
                ageMax: age.value[1],
                gender: gender.value,
                study: study.value)) {
                    
            switch $0 {
            case .success:
                completion(.success(.perfact))
            case .failure(let error):
                switch error {
                case .idTokenError:
                    completion(.failure(.idTokenError))
                    self.updateUserInfo { _  in }
                    
                case .unRegistedUser:
                    completion(.failure(.unRegistedUser))
                    //⚠️다시 회원가입 -> 로그인 로직 타야됨 --> 회원가입 으로 이동
                default:
                    return
                }
            }
        }
    }
}



extension MyInfoViewModel {
    func requestWithdraw(completion: @escaping (Result<Succeess, MemoleaseError>) -> Void) {
        
        let target = UserRouter.withdraw
        
        MemoleaseService.shared.requestWithdraw(target: UserRouter.withdraw) { result in
                
                switch result {
                case .success:
                    completion(.success(.perfact)) //🚀 vc 에서 처리
                case .failure(let error):
                    switch error {
                    case .idTokenError:
                        self.updateUserInfo { _  in } // 💫 재귀 로그인 시작
                    case .aleadyWithdraw:
                        completion(.failure(.aleadyWithdraw)) // 🚀 vc 에서 처리
                    default:
                        return
                    }
                    
                }
            }
    }
}
    
    
    
    

    
