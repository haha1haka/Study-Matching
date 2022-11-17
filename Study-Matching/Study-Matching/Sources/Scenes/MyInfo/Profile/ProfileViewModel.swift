import Foundation
import RxSwift
import RxCocoa

class ProfileViewModel {
    let bacground = BehaviorRelay<Int>(value: 0)
    let sesac = BehaviorRelay<Int>(value: 0)
    let nick = BehaviorRelay<String>(value: "")
    let reputation = BehaviorRelay<[Int]>(value: [])
    let comment = BehaviorRelay<[String]>(value: [])
    let gender = BehaviorRelay<Int>(value: 0)
    let study = BehaviorRelay<[String]>(value: [])
    let searchable = BehaviorRelay<Bool>(value: false)
    let age = BehaviorRelay<[Int]>(value: [])
    
    //회원 탈퇴
    //저장버튼
}
