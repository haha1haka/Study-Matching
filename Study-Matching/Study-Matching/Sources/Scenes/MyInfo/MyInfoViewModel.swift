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
    var userMainDTO: UserMainDTO?
    var userSubDTO: UserSubDTO?

}

extension MyInfoViewModel {
    
    
    func fetchUserInfo(completion: @escaping (Result<Succeess, MemoleaseError>) -> Void) {
        
        let target = MemoleaseRouter.signIn
        
        MemoleaseService.shared.requestUserInfo(path: target.path, queryItems: nil, httpMethod: target.httpMethod, headers: target.headers) { [weak self] result in
            
            guard let self = self else { return }
            
            switch result {
            case .success(let user):
                self.userMainDTO = UserMainDTO(nick: user.nick, comment: user.comment, reputation: user.reputation, sesac: user.sesac, background: user.background)
                userSubDTO =  UserSubDTO(gender: user.gender, study: user.study, searchable: user.searchable, ageMin: user.ageMin, ageMax: user.ageMax)
                
                
                
                
                completion(.success(.perfact))
            case .failure(let error):
                switch error {
                case .firebaseTokenError:
                    
                    self.updateFCMToken { result in //🚀 updateFCMToken
                        switch result {
                        case .success:
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
                case .firebaseTokenError: //또 재갱신? 무한 츠크요미
                    return
                case .unRegistedUser: // 이럴 경우 없음
                    return
                case .serverError: // 이럴 경우 없음
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
