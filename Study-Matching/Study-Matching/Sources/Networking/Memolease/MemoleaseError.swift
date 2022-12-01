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
    
    //회원탈퇴
    case aleadyWithdraw
    
    //새싹 요청
    case unavailable
    case penalty1
    case penalty2
    case penalty3
    
    //queuestate
    case defaultState
    
    
    //studyrequest
    case searchStop
    
}
