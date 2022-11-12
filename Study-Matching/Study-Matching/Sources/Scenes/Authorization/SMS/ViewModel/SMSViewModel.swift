import Foundation
import RxSwift
import RxCocoa

class SMSViewModel {
    
    var textFieldTextObserverable = BehaviorSubject<String>(value: "")
    var dividerViewFlag = BehaviorRelay<Bool>(value: false)
    var validationFlag = BehaviorRelay<Bool>(value: false)
    
    func validHandler(text: String) -> Bool {
        if text.count == 6 {
            return true
        } else {
            return false
        }
    }
    
    func applydividerView(_ inputText: String) -> Bool {
        return inputText.isEmpty
    }
}
