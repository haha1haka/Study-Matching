import Foundation
import RxSwift
import RxCocoa



class AuthViewModel: ResultType {
    
    var textFieldTextObserverable = BehaviorSubject<String>(value: "")
    var dividerViewFlag = BehaviorRelay<Bool>(value: false)
    var validationFlag = BehaviorRelay<Bool>(value: false)
    
    
    
    func validHandler(text: String) -> Bool {
        let textRegex = "^01([0-9])+-([0-9]{3,4})+-([0-9]{4})$"
        let predicate = NSPredicate(format:"SELF MATCHES %@", textRegex)
        return predicate.evaluate(with: text)
    }
    

    func applydividerView(_ inputText: String) -> Bool {
        return inputText.isEmpty
    }

    
    func applyHyphen(_ inputText: String) -> String {
        let string = inputText.replacingOccurrences(of: "-", with: "")
        let array = Array(string)
        if array.count > 3 {
            if let regex = try? NSRegularExpression(
                pattern: "([0-9]{3})([0-9]{4})([0-9]{4})",
                options: .caseInsensitive)
            {
                let modString = regex.stringByReplacingMatches(
                    in: string,
                    options: [],
                    range: NSRange(string.startIndex..., in: string),
                    withTemplate: "$1-$2-$3")
                return modString
            }
        }
        return inputText
    }
    
    
    func requestVertificationID(phoneNumber: String, completion: @escaping FirebaseResult) {
        
        FirebaseService.shared.requestVertificationID(phoneNumber: phoneNumber) {
            switch $0 {
            case .success:
                completion(.success(.perfact))
            case .failure(let error):
                switch error {
                case .tooManyRequest:
                    completion(.failure(.tooManyRequest))
                default:
                    completion(.failure(.unknown))
                }
            }
        }
    }
}
