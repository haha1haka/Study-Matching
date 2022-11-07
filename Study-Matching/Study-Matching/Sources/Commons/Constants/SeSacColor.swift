import UIKit

enum SeSacColor: String {
    case white, black
    case green, whitegreen, yellowgreen
    case gray1, gray2, gray3, gray4, gray5, gray6, gray7
    case success, error, focus
}

extension SeSacColor {
    var set: UIColor {
        return UIColor(named: self.rawValue)!
    }
}
