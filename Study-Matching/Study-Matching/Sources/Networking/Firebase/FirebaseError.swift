import Foundation

enum Succeess {
    case perfact
}

enum FirebaseError: String, Error {
    case noneVertificationID
    case tooManyRequest
    case unknown
    
    case mismatchSMSCode
    case invalidVerificationCode

}
