import Foundation
import RxSwift
import RxCocoa

class GenderViewModel: ResultType {
    //여자: 0 (false), 남자 1 (true)
    var collectionViewObservable = BehaviorRelay<Int>(value: -1)

}

extension GenderViewModel {
    func requestSignup(completion: @escaping MemoleaseResult) {
        MemoleaseService.shared.requestSignup(
            target: MemoleaseRouter.signup(
                phoneNumber: UserDefaultsManager.standard.phoneNumber,
                FCMtoken: UserDefaultsManager.standard.FCMToken,
                nick: UserDefaultsManager.standard.nick,
                birth: UserDefaultsManager.standard.birth,
                email: UserDefaultsManager.standard.email,
                gender: UserDefaultsManager.standard.gender)) {
                    let a = MemoleaseRouter.signup(
                        phoneNumber: UserDefaultsManager.standard.phoneNumber,
                        FCMtoken: UserDefaultsManager.standard.FCMToken,
                        nick: UserDefaultsManager.standard.nick,
                        birth: UserDefaultsManager.standard.birth,
                        email: UserDefaultsManager.standard.email,
                        gender: UserDefaultsManager.standard.gender)
                    print(a.path, a.queryItems, a.httpMethod, a.headers)
                    
                    
                    
                    
                    switch $0 {
                    case .success:
                            completion(.success(.perfact)) //🚀
                    case .failure(let error):
                        switch error {
                        case .alreadyUser:
                            completion(.failure(.alreadyUser)) //🚀
                        case .nickError:
                            completion(.failure(.nickError)) //🚀
                        default:
                            print("알수 없는 유저임")
                        }
                    }
                    
                }
    }
    

}
