import Foundation

enum MemoleaseError: Int, Error {
    case alreadyUser = 201
    case nickError = 202
    case firebaseTokenError = 401
    case serverError = 500
    case clientError = 501
    case unknown
}
