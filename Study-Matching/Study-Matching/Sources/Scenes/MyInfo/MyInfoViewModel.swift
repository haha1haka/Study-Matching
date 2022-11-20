import Foundation
import RxSwift
import RxCocoa

class MyInfoViewModel {
    
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
    var ageMax     = BehaviorRelay<Int>(value: 0)
    var ageMin     = BehaviorRelay<Int>(value: 0)
    let age        = BehaviorRelay<[Int]>(value: [])
    var user       = BehaviorRelay<MemoleaseUser?>(value: nil)
    //회원 탈퇴
    //저장버튼
}

extension MyInfoViewModel {
    
    
    
    func fetchUserInfo(completion: @escaping (Result<Succeess, MemoleaseError>) -> Void) {
        
        let target = MemoleaseRouter.signIn
        
        MemoleaseService.shared.requestLogin(
            path: target.path,
            queryItems: nil,
            httpMethod: target.httpMethod,
            headers: target.headers) { [weak self] result in
            
            guard let self = self else { return }
            
            switch result {
            case .success(let user):
                self.background.accept(user.background)
                self.sesac.accept(user.sesac)
                self.nick.accept(user.nick)
                self.reputation.accept(user.reputation)
                self.comment.accept(user.comment)
                self.gender.accept(user.gender)
                self.study.accept(user.study)
                self.searchable.accept(user.searchable)
                self.ageMax.accept(user.ageMax)
                self.ageMin.accept(user.ageMin)
                self.age.accept([user.ageMin,user.ageMax])
                self.user.accept(user)
                completion(.success(.perfact))
            case .failure(let error):
                switch error {
                case .idTokenError:
                    
//                    self.updateFCMToken { result in //🚀 updateFCMToken
//                        switch result {
//                        case .success:
//                            return
//                        case .failure:
//                            return
//                        }
//                    }
                    
                    print("\(error.localizedDescription)")
                case .unRegistedUser:
                    return
                case .serverError:
                    print("\(error.localizedDescription)")
                case .clientError:
                    print("\(error.localizedDescription)")
                default:
                    return
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
    
    func updateUserInfo(completion: @escaping (Result<Succeess, MemoleaseError>) -> Void) {
        
        let target = MemoleaseRouter.updateUserInfo(
            searchable: searchable.value,
            ageMin: age.value[0],
            ageMax: age.value[1],
            gender: gender.value,
            study: study.value)
        
        MemoleaseService.shared.updateUserInfo(
            path: target.path,
            queryItems: target.queryItems,
            httpMethod: target.httpMethod,
            headers: target.headers) { result in
                
            switch result {
            case .success:
                completion(.success(.perfact))
            case .failure(let error):
                switch error {
                case .idTokenError:
                    completion(.failure(.idTokenError))
                    
                    self.updateUserInfo { _  in } // 다시 재귀 요청
                    
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
