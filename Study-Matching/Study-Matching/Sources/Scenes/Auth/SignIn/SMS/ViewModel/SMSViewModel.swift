import Foundation
import RxSwift
import RxCocoa

class SMSViewModel: ResultType {
    
    var textFieldTextObserverable = BehaviorSubject<String>(value: "")
    var dividerViewFlag = BehaviorRelay<Bool>(value: false)
    var validationFlag = BehaviorRelay<Bool>(value: false)
    
    func validHandler(text: String) -> Bool {
        if text.count == 6 {
            return true
        } else {
            return false
        }
    }
    
    func applydividerView(_ inputText: String) -> Bool {
        return inputText.isEmpty
    }
}

extension SMSViewModel {
    func vertifySMSCode(smsCode: String, completion: @escaping FirebaseResult) {
        print(#function)
        FirebaseService.shared.vertifySMSCode(smsCode: smsCode) {
            switch $0 {
            case .success:
                    completion(.success(.perfact))
            case .failure(let error):
                switch error {
                case .invalidVerificationCode:
                    completion(.failure(.invalidVerificationCode))
                case .tooManyRequest:
                    completion(.failure(.tooManyRequest))
                default:
                    completion(.failure(.unknown))
                }
            }
        }
    }
}

extension SMSViewModel {
    func requestUserInfo(completion: @escaping (Result<String, MemoleaseError>) -> Void ) {
        print(#function)
        MemoleaseService.shared.requestGetUser(target: UserRouter.signIn) {
            switch $0 {
            case .success:
                completion(.success(""))
            case .failure(let error):
                switch error {
                case .unRegistedUser:
                    completion(.failure(.unRegistedUser))
                case .idTokenError:
                    completion(.failure(.idTokenError))
                default:
                    return
                }
            }
            
        }
    }
}
