import Foundation
import RxSwift
import RxCocoa

class EmailViewModel {
    
    var textFieldTextObserverable = BehaviorSubject<String>(value: "")
    var dividerViewFlag = BehaviorRelay<Bool>(value: false)
    var validationFlag = BehaviorRelay<Bool>(value: false)
    
    func validHandler(_ text: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: text)
    }
    
    func applydividerView(_ inputText: String) -> Bool {
        return inputText.isEmpty
    }
    
}
