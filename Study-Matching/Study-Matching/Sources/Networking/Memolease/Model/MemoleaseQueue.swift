import Foundation


struct MemoleaseQueue: Codable {
    let fromQueueDB          : [FromQueueDB]
    let fromQueueDBRequested : [FromQueueDB]
    let fromRecommend        : [String]
}

struct FromQueueDB: Codable {
    let uid       : String
    let nick      : String
    let lat       : Double
    let long      : Double
    let reputation: [Int]
    let studylist : [String]
    let reviews   : [String]
    let gender    : Int
    let type      : Int
    let sesac     : Int
    let background: Int
}
