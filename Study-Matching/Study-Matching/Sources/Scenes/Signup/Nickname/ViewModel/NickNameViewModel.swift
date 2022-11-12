import Foundation
import RxSwift
import RxCocoa

class NickNameViewModel {
    
    var textFieldTextObserverable = BehaviorSubject<String>(value: "")
    var dividerViewFlag = BehaviorRelay<Bool>(value: false)
    var validationFlag = BehaviorRelay<Bool>(value: false)
    
    
    func validHandler(_ text: String) -> Bool {
        
        if text.count > 1 && text.count < 10 {
            return true
        } else {
            return false
        }
    }
    func applydividerView(_ inputText: String) -> Bool {
        return inputText.isEmpty
    }
}
