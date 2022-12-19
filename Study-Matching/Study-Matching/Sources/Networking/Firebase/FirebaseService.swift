import Foundation
import FirebaseAuth



class FirebaseService: ResultType {
    
    static let shared = FirebaseService()
    
    private init() {}
    
    func requestVertificationID(phoneNumber: String, completion: @escaping FirebaseResult) {
        
        PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber, uiDelegate: nil) { vertificationID, error in
            
            guard let vertificationID = vertificationID else {
                completion(.failure(.noneVertificationID))
                return
            }
            
            if let error = error {
                let errorStatus = AuthErrorCode.Code(rawValue: error._code)
                switch errorStatus {
                case .tooManyRequests:
                    completion(.failure(.tooManyRequest))
                default:
                    completion(.failure(.unknown))
                }
            }
            else {
                UserDefaultsManager.standard.vertificationID = vertificationID
                completion(.success(.perfact))
            }
            
        }
        
    }
    
    
    
    func vertifySMSCode(smsCode: String, completion: @escaping FirebaseResult) {
        
        let vertificationId = UserDefaultsManager.standard.vertificationID
        
        let credential = PhoneAuthProvider.provider().credential(withVerificationID: vertificationId, verificationCode: smsCode)
        
        Auth.auth().signIn(with: credential) { result, error in
            
            if let error = error {
                let errorStatus = AuthErrorCode.Code(rawValue: error._code)
                switch errorStatus {
                case .tooManyRequests:
                    completion(.failure(.tooManyRequest))
                case .invalidVerificationCode:
                    completion(.failure(.invalidVerificationCode))
                case .sessionExpired:
                    completion(.failure(.expired))
                default:
                    completion(.failure(.unknown))
                }
            }
            else {
                self.fetchIdToken { _ in }
                completion(.success(.perfact))
            }
        }
    }
    
    
    
    func fetchIdToken(completion: @escaping (Result<Succeess, FirebaseError>) -> Void) {
        
        let currentUser = Auth.auth().currentUser
        
        currentUser?.getIDTokenForcingRefresh(true) { idToken, error in
            
            if let error = error {
                print(" ❌ idToken \(error)")
                completion(.failure(.idTokenFetchError))
                return
            }
            else {
                guard let idToken = idToken else { print("idToken == nil"); return }
                
                UserDefaultsManager.standard.idToken = idToken
                
                completion(.success(.perfact))
                
                print("♻️♻️♻️IDTOKEN갱신\(UserDefaultsManager.standard.idToken)")
                
            }
            
        }
        
        
    }
    
}


