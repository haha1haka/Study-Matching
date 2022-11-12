import Foundation
import RxSwift
import RxCocoa

class AuthViewModel {
    var textFieldTextObserverable = BehaviorSubject<String>(value: "")
    var validation = BehaviorRelay<Bool>(value: false)
    
    //⚠️ 핸들러 개선
    func validHandler(text: String) -> Bool {
        if text.count < 13 {
            return true
        } else {
            return false
        }
    }
    
    func applyHyphen(_ inputText: String) -> String {
        let string = inputText.replacingOccurrences(of: "-", with: "")
        let array = Array(string)
        if array.count > 3 {
            if let regex = try? NSRegularExpression(pattern: "([0-9]{3})([0-9]{4})([0-9]{4})", options: .caseInsensitive) {
                let modString = regex.stringByReplacingMatches(in: string, options: [], range: NSRange(string.startIndex..., in: string), withTemplate: "$1-$2-$3")
                return modString
            }
        }
        return inputText
    }
    
}
