import Foundation

enum Succeess {
    case perfact
    
    
    //studyrequest
    case alreadyRequested
    
    //studyAccepts
    case alreadyMatching
    case searchStoping
    case someoneWhoLikesMe
    
    
}

enum MemoleaseError: Error {
    
    //회원가입
    case alreadyUser
    case nickError
    case idTokenError
    
    case serverError
    case clientError
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
    case canceledMatch
    
    
    //studyrequest
    case searchStop
    
    //chat
    case unableChat

    //dodge
    case wrongUid
    
}
