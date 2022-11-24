import Foundation
import FirebaseAuth



class FirebaseService: ResultType {
    
    static let shared = FirebaseService()
    
    private init() {}
    
    func requestVertificationID(
        phoneNumber: String,
        completion: @escaping FirebaseResult)
    {
        PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber, uiDelegate: nil)
        { vertificationID, error in
            guard let vertificationID = vertificationID else {
                completion(.failure(.noneVertificationID))
                return
            }
            print("🐙🐙🐙🐙\(vertificationID)")
            
            if let error = error {
                let errorStatus = AuthErrorCode.Code(rawValue: error._code)
                switch errorStatus {
                case .tooManyRequests:
                    completion(.failure(.tooManyRequest)) // 🚀
                default:
                    completion(.failure(.unknown))
                }
            }
            
            UserDefaultsManager.standard.vertificationID = vertificationID
            completion(.success(.perfact))
            
        }
        
    }
    
    
    
    func vertifySMSCode(
        smsCode: String,
        completion: @escaping FirebaseResult)
    {
        print("🟩 VerrificationID : \(UserDefaultsManager.standard.vertificationID)")
        
        let vertificationId = UserDefaultsManager.standard.vertificationID
        
        let credential = PhoneAuthProvider.provider().credential(withVerificationID: vertificationId, verificationCode: smsCode)
        
        Auth.auth().signIn(with: credential) { result, error in
            
            
            if let error = error {
                let errorStatus = AuthErrorCode.Code(rawValue: error._code)
                switch errorStatus {
                case .tooManyRequests:
                    completion(.failure(.tooManyRequest)) // 🚀
                case .invalidVerificationCode:
                    completion(.failure(.invalidVerificationCode)) // 🚀
                default:
                    completion(.failure(.unknown))
                }
            }
            else { // 1. SMS 코드 일치 하면 token 깔기
                self.fetchIdToken { _ in }
                completion(.success(.perfact)) // 🚀
            }
        }
    }
    
    
    
    func fetchIdToken(completion: @escaping (Result<Succeess, FirebaseError>) -> Void)
    {
        let currentUser = Auth.auth().currentUser
        currentUser?.getIDTokenForcingRefresh(true) { idToken, error in
            if let error = error {
                print(" ❌ idToken \(error)")
                completion(.failure(.idTokenFetchError))
                return
            } else {
                guard let idToken = idToken else { print("idToken == nil"); return }
                
                UserDefaultsManager.standard.idToken = idToken
                completion(.success(.perfact))
                print("♻️idToken갱신!♻️\(UserDefaultsManager.standard.idToken)♻️♻️♻️")
                
            }
            
        }
        
        
    }
    
}




//case .none:
//    <#code#>
//case .some(.invalidCustomToken):
//    <#code#>
//case .some(.customTokenMismatch):
//    <#code#>
//case .some(.invalidCredential):
//    <#code#>
//case .some(.userDisabled):
//    <#code#>
//case .some(.operationNotAllowed):
//    <#code#>
//case .some(.emailAlreadyInUse):
//    <#code#>
//case .some(.invalidEmail):
//    <#code#>
//case .some(.wrongPassword):
//    <#code#>
//case .some(.userNotFound):
//    <#code#>
//case .some(.accountExistsWithDifferentCredential):
//    <#code#>
//case .some(.requiresRecentLogin):
//    <#code#>
//case .some(.providerAlreadyLinked):
//    <#code#>
//case .some(.noSuchProvider):
//    <#code#>
//case .some(.invalidUserToken):
//    <#code#>
//case .some(.networkError):
//    <#code#>
//case .some(.userTokenExpired):
//    <#code#>
//case .some(.invalidAPIKey):
//    <#code#>
//case .some(.userMismatch):
//    <#code#>
//case .some(.credentialAlreadyInUse):
//    <#code#>
//case .some(.weakPassword):
//    <#code#>
//case .some(.appNotAuthorized):
//    <#code#>
//case .some(.expiredActionCode):
//    <#code#>
//case .some(.invalidActionCode):
//    <#code#>
//case .some(.invalidMessagePayload):
//    <#code#>
//case .some(.invalidSender):
//    <#code#>
//case .some(.invalidRecipientEmail):
//    <#code#>
//case .some(.missingEmail):
//    <#code#>
//case .some(.missingIosBundleID):
//    <#code#>
//case .some(.missingAndroidPackageName):
//    <#code#>
//case .some(.unauthorizedDomain):
//    <#code#>
//case .some(.invalidContinueURI):
//    <#code#>
//case .some(.missingContinueURI):
//    <#code#>
//case .some(.missingPhoneNumber):
//    <#code#>
//case .some(.invalidPhoneNumber):
//    <#code#>
//case .some(.missingVerificationCode):
//    <#code#>
//case .some(.invalidVerificationCode):
//    <#code#>
//case .some(.missingVerificationID):
//    <#code#>
//case .some(.invalidVerificationID):
//    <#code#>
//case .some(.missingAppCredential):
//    <#code#>
//case .some(.invalidAppCredential):
//    <#code#>
//case .some(.sessionExpired):
//    <#code#>
//case .some(.quotaExceeded):
//    <#code#>
//case .some(.missingAppToken):
//    <#code#>
//case .some(.notificationNotForwarded):
//    <#code#>
//case .some(.appNotVerified):
//    <#code#>
//case .some(.captchaCheckFailed):
//    <#code#>
//case .some(.webContextAlreadyPresented):
//    <#code#>
//case .some(.webContextCancelled):
//    <#code#>
//case .some(.appVerificationUserInteractionFailure):
//    <#code#>
//case .some(.invalidClientID):
//    <#code#>
//case .some(.webNetworkRequestFailed):
//    <#code#>
//case .some(.webInternalError):
//    <#code#>
//case .some(.webSignInUserInteractionFailure):
//    <#code#>
//case .some(.localPlayerNotAuthenticated):
//    <#code#>
//case .some(.nullUser):
//    <#code#>
//case .some(.dynamicLinkNotActivated):
//    <#code#>
//case .some(.invalidProviderID):
//    <#code#>
//case .some(.tenantIDMismatch):
//    <#code#>
//case .some(.unsupportedTenantOperation):
//    <#code#>
//case .some(.invalidDynamicLinkDomain):
//    <#code#>
//case .some(.rejectedCredential):
//    <#code#>
//case .some(.gameKitNotLinked):
//    <#code#>
//case .some(.secondFactorRequired):
//    <#code#>
//case .some(.missingMultiFactorSession):
//    <#code#>
//case .some(.missingMultiFactorInfo):
//    <#code#>
//case .some(.invalidMultiFactorSession):
//    <#code#>
//case .some(.multiFactorInfoNotFound):
//    <#code#>
//case .some(.adminRestrictedOperation):
//    <#code#>
//case .some(.unverifiedEmail):
//    <#code#>
//case .some(.secondFactorAlreadyEnrolled):
//    <#code#>
//case .some(.maximumSecondFactorCountExceeded):
//    <#code#>
//case .some(.unsupportedFirstFactor):
//    <#code#>
//case .some(.emailChangeNeedsVerification):
//    <#code#>
//case .some(.missingOrInvalidNonce):
//    <#code#>
//case .some(.missingClientIdentifier):
//    <#code#>
//case .some(.keychainError):
//    <#code#>
//case .some(.internalError):
//    <#code#>
//case .some(.malformedJWT):
//    <#code#>
//case .some(_):
//    <#code#>
