import Foundation
import FirebaseAuth


enum Succeess {
    case perfact
}

enum FirebaseError: String, Error {
    case noneVertificationID
    case tooManyRequest
    case unknown
}



class FirebaseService {
    
    static let shared = FirebaseService()
    
    private init() {}
    
    func requestVertificationID(phoneNumber: String, completion: @escaping (Result<Succeess, FirebaseError>) -> Void) {
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
            
            
            print("🐙🐙🐙🐙\(vertificationID)")
            UserDefaultsManager.standard.vertificationID = vertificationID
            completion(.success(.perfact))
            
        }
        
    }
    
    
    
    func requestSignIn(smsCode: String, completion: @escaping (Result<Succeess, FirebaseError>) -> Void) {
        
        print("🟩 VerrificationID : \(UserDefaultsManager.standard.vertificationID)")
        
        let vertificationId = UserDefaultsManager.standard.vertificationID
        
        let credential = PhoneAuthProvider.provider().credential(withVerificationID: vertificationId, verificationCode: smsCode)
        
        Auth.auth().signIn(with: credential) { result, error in
            print("🔥🔥🔥\(error.debugDescription)")
            guard result != nil, error == nil else {
                completion(.failure(.unknown))
                return
                

            }
            
            completion(.success(.perfact))
        }
    }
    
    
    
    func requestRefreshIdToken(completion: @escaping (Result<Succeess, FirebaseError>) -> Void) {
        let currentUser = Auth.auth().currentUser
        currentUser?.getIDTokenForcingRefresh(true) { idToken, error in
            if let error = error {
                print(" ❌ \(error)")
                completion(.failure(.unknown))
                return
            }
            
            guard let idToken = idToken else { print("idToken == nil"); return }
            UserDefaultsManager.standard.idToken = idToken
            completion(.success(.perfact))
        }
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
}




