import Foundation
import RxSwift
import RxCocoa

class MyInfoViewModel {
    let background = BehaviorRelay<Int>(value: 0)
    let sesac = BehaviorRelay<Int>(value: 0)
    let nick = BehaviorRelay<String>(value: "")
    let reputation = BehaviorRelay<[Int]>(value: [])
    let comment = BehaviorRelay<[String]>(value: [])
    let gender = BehaviorRelay<Int>(value: 0)
    let study = BehaviorRelay<String>(value: "")
    let searchable = BehaviorRelay<Int>(value: 0)
    let age = BehaviorRelay<[Int]>(value: [])
    
    //회원 탈퇴
    //저장버튼
}

extension MyInfoViewModel {
    
    
    
    func fetchUserInfo(completion: @escaping (Result<Succeess, MemoleaseError>) -> Void) {
        
        let target = MemoleaseRouter.signIn
        
        MemoleaseService.shared.requestUserInfo(path: target.path, queryItems: nil, httpMethod: target.httpMethod, headers: target.headers) { [weak self] result in
            
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
                self.age.accept([user.ageMin,user.ageMax])
                completion(.success(.perfact))
            case .failure(let error):
                switch error {
                case .firebaseTokenError:
                    self.updateFCMToken { result in
                        switch result {
                        case .success: //🚀 updateFCMToken
                            return
                        case .failure:
                            return
                        }
                    }
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
    
    func updateFCMToken(completion: @escaping (Result<Succeess, MemoleaseError>) -> Void) {
        let target = MemoleaseRouter.updateToken
        MemoleaseService.shared.updateFCMToken(path: target.path, queryItems: nil, httpMethod: target.httpMethod, headers: target.headers) { result in
            switch result {
            case .success:
                completion(.success(.perfact))
            case .failure(let error):
                switch error {
                case .firebaseTokenError:
                    //재갱신? 무한 츠크요미
                    return
                case .unRegistedUser:
                    return
                case .serverError:
                    return
                case .clientError:
                    print("\(error.localizedDescription)")
                default:
                    print("\(error.localizedDescription)")
                    
                }
            }
        }
    }
    

}
