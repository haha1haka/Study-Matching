import Foundation

enum MemoleaseError: Int, Error {
    
    //회원가입
    case alreadyUser = 201
    case nickError = 202
    case idTokenError = 401
    
    case serverError = 500
    case clientError = 501
    case unknown
    
    //로그인
    case decodingError
    case unRegistedUser
}
