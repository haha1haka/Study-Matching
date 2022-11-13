import Foundation
import FirebaseAuth



class FirebaseService {
    
    static let shared = FirebaseService()
    
    private init() {}
    
    func requestVertificationID(phoneNumber: String, completion: @escaping (Bool) -> Void) {
        PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber, uiDelegate: nil) { vertificationID, error in
            
            guard let vertificationID = vertificationID, error == nil else {
                completion(false)
                return
            }
            //에러 어떻게 넘어 오냐 에 따라 분기 처리 해주기
            print("🔥🔥🔥\(error.debugDescription)")
            
            print("🐙🐙🐙🐙\(vertificationID)")
            
            UserDefaultsManager.standard.vertificationID = vertificationID
            
            completion(true)
            
        }
        
    }
    
    
    
    func requestSignIn(smsCode: String, completion: @escaping (Bool) -> Void) {
        
        print("🟩 VerrificationID : \(UserDefaultsManager.standard.vertificationID)")
        
        let vertificationId = UserDefaultsManager.standard.vertificationID
        
        let credential = PhoneAuthProvider.provider().credential(withVerificationID: vertificationId, verificationCode: smsCode)
        
        Auth.auth().signIn(with: credential) { result, error in
            print("🔥🔥🔥\(error.debugDescription)")
            guard result != nil, error == nil else {
                completion(false)
                return
            }
            completion(true)
        }
    }
    
    
    
    func requestRefreshIdToken(completion: @escaping (Bool) -> Void) {
        let currentUser = Auth.auth().currentUser
        currentUser?.getIDTokenForcingRefresh(true) { idToken, error in
            if let error = error {
                print(" ❌ \(error)")
                completion(false)
                return
            }
            
            guard let idToken = idToken else { print("idToken == nil"); return }
            UserDefaultsManager.standard.idToken = idToken
            completion(true)
        }
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
}
