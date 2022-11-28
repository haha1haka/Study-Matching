import Foundation

protocol ResultType {
    typealias FirebaseResult = (Result<Succeess, FirebaseError>) -> Void
    typealias MemoleaseResult = (Result<Succeess, MemoleaseError>) -> Void
    typealias MemoleaseUserGetResult = (Result<MemoleaseUser, MemoleaseError>) -> Void
    typealias MemoleaseQueueSearchPostResult = (Result<Queue, MemoleaseError>) -> Void
}
