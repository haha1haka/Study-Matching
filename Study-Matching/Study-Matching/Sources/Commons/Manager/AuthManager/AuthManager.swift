import Foundation
import FirebaseAuth




class AuthManager {
    
    static let shared = AuthManager()
    
    private init() {}
    
    var vertificationId: String?
    
    func startAuth(phoneNumber: String, completion: @escaping (Bool) -> Void) {
        PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber, uiDelegate: nil) { [weak self] vertificationID, error in
            guard let self = self else { return }
            guard let vertificationID = vertificationID, error == nil else {
                completion(false)
                return
            }
            print("🔥🔥🔥\(error.debugDescription)")
            self.vertificationId = vertificationID
            print("🐙🐙🐙🐙\(vertificationID)")
            UserDefaultsManager.shared.setVertificationID(vertificationID)
            completion(true)
            
        }
        
    }
    
    func verifyCode(smsCode: String, completion: @escaping (Bool) -> Void) {
        guard let vertificationId = UserDefaultsManager.shared.getVertificationID() else {
            completion(false)
            return
        }
        
        let credential = PhoneAuthProvider.provider().credential(withVerificationID: vertificationId, verificationCode: smsCode)
        
        Auth.auth().signIn(with: credential) { result, error in
            guard result != nil, error == nil else {
                completion(false)
                return
            }
            completion(true)
        }
    }
}
