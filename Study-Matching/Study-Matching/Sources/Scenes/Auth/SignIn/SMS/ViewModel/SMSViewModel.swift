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
    

    
//    FirebaseService.shared.vertifySMSCode(smsCode: smsCode) { result in
//
//        switch result {
//        case .success:
//            UserDefaultsManager.standard.smsFlag = true //⭐️ 전화번호 인증완료된후에는 시작 화면 Nick 으로 나오게 할려고
//            FirebaseService.shared.fetchIdToken { reuslt in
//                switch reuslt {
//                case .success(.perfact):
//                    //self.requestUserInfo() //🚨
//                    return
//                case .failure(let error):
//                    switch error {
//                    case .idTokenFetchError:
//                        self.showToast(message: "ID토큰오류: 에러가 발생했습니다. 잠시 후 다시 시도해주세요")
//                    default:
//                        self.showToast(message: "알수없는 토큰 업데이트 에러")
//                    }
//                }
//            }
//
//        case .failure(let error):
//            switch error {
//            case .invalidVerificationCode:
//                self.showToast(message: "인증번호불일치: 전화번호 인증 실패")
//            case .tooManyRequest:
//                print("너무 잦은 요청")
//            default:
//                print("그외 모든 에러 --> \(error.localizedDescription)")
//            }
//        }
//    }
}
extension SMSViewModel {
    func vertifySMSCode(smsCode: String, completion: @escaping FirebaseResult) {
        print(#function)
        FirebaseService.shared.vertifySMSCode(smsCode: smsCode) {
            switch $0 {
            case .success:
                    completion(.success(.perfact)) //🚀
            case .failure(let error):
                switch error {
                case .invalidVerificationCode:
                    completion(.failure(.invalidVerificationCode)) //🚀
                case .tooManyRequest:
                    completion(.failure(.tooManyRequest)) //🚀
                default:
                    completion(.failure(.unknown)) //🚀
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
                completion(.success("")) //🚀 vc에서 화면전환
            case .failure(let error):
                switch error {
                case .unRegistedUser:   // 🚀
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
