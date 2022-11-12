import Foundation
import RxSwift
import RxCocoa

class AuthViewModel {
    var textFieldTextObserverable = BehaviorSubject<String>(value: "")
    var validation = BehaviorRelay<Bool>(value: false)
    
    
    func validHandler(text: String) -> Bool {
        let textRegex = "^01([0-9])+-([0-9]{3,4})+-([0-9]{4})$"
        let predicate = NSPredicate(format:"SELF MATCHES %@", textRegex)
        return predicate.evaluate(with: text)
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
