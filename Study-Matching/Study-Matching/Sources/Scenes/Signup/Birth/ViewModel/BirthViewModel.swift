import Foundation
import RxSwift
import RxCocoa

class BirthViewModel {
    
    let datePickerObservable = BehaviorRelay<Date>(value: Date())
    var dividerViewFlag = BehaviorRelay<Bool>(value: false)
    var validationFlag = BehaviorRelay<Bool>(value: false)
    
    
    
    //너무 안예쁘다 개선 해보기
    func validHandler(_ date: Date) -> Bool {
        let today = Date()
        if today.year - date.year == 17 {
            if today.month - date.month >= 0 {
                if today.day - date.day >= 0 {
                    return true
                }
                return false
            }
        } else if today.year - date.year > 17 {
            return true
        } else {
            return false
        }
        
        return false
    }
    
    
    func applydividerView(_ inputText: String) -> Bool {
        return inputText.isEmpty
    }
    

    
}









