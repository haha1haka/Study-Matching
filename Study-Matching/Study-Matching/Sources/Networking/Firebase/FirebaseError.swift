import Foundation

enum Succeess {
    case perfact
}

enum FirebaseError: String, Error {
    //Auth
    case noneVertificationID
    case tooManyRequest
    case unknown
    
    
    //SMS
    case mismatchSMSCode
    case invalidVerificationCode
    
    //refeshError
    case refreshError
    

}
