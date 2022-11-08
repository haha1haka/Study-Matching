import UIKit


enum SeSacFont: String {
    case Display1_R20
    case Title1_M16, Title2_R16, Title3_M14, Title4_R14, Title5_M12, Title6_R12
    case Body1_M16, Body2_R16, Body3_R14, Body4_R12
    case caption_R10
    
    static let notoSansCJKkrRegular = "NotoSansCJKkr-Regular"
    static let notoSansCJKkrMedium = "NotoSansCJKkr-Medium"
}

extension SeSacFont {
    var set: UIFont {
        switch self {
        case .Display1_R20:
            return UIFont(name: SeSacFont.notoSansCJKkrRegular, size: 20)!
        case .Title1_M16:
            return UIFont(name: SeSacFont.notoSansCJKkrMedium, size: 16)!
        case .Title2_R16:
            return UIFont(name: SeSacFont.notoSansCJKkrRegular, size: 16)!
        case .Title3_M14:
            return UIFont(name: SeSacFont.notoSansCJKkrMedium, size: 14)!
        case .Title4_R14:
            return UIFont(name: SeSacFont.notoSansCJKkrRegular, size: 14)!
        case .Title5_M12:
            return UIFont(name: SeSacFont.notoSansCJKkrMedium, size: 12)!
        case .Title6_R12:
            return UIFont(name: SeSacFont.notoSansCJKkrRegular, size: 12)!
        case .Body1_M16:
            return UIFont(name: SeSacFont.notoSansCJKkrMedium, size: 16)!
        case .Body2_R16:
            return UIFont(name: SeSacFont.notoSansCJKkrRegular, size: 16)!
        case .Body3_R14:
            return UIFont(name: SeSacFont.notoSansCJKkrRegular, size: 14)!
        case .Body4_R12:
            return UIFont(name: SeSacFont.notoSansCJKkrRegular, size: 12)!
        case .caption_R10:
            return UIFont(name: SeSacFont.notoSansCJKkrRegular, size: 10)!
        }
    }
}
