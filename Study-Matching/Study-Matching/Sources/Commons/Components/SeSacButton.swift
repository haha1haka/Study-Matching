import UIKit

enum SeSacButtonType {
    case login
    case myInfo
    case map
    case search
    case settingTap
    case settingRequest
}


class SeSacButton: UIButton {
    var tagString: String?
    convenience init(frame: CGRect = .zero,
                     title: String,
                     color: UIColor = SeSacColor.gray6,
                     font_: UIFont = SeSacFont.Body3_R14.set,
                     type: SeSacButtonType = .login,
                     tag_: Int = .zero
                     )
    {
        self.init(frame: frame)

        switch type {
        case .login:
            backgroundColor = color
            titleLabel?.font = font_
            setTitle(title, for: .normal)
            layer.cornerRadius = 8
            layer.masksToBounds = true
        case .myInfo:
            titleLabel?.font = font_
            layer.cornerRadius = 8
            layer.borderWidth = 1
            layer.masksToBounds = true
            backgroundColor = SeSacColor.white
            layer.borderColor = SeSacColor.gray4.cgColor
            setTitle(title, for: .normal)
            setTitleColor(SeSacColor.black, for: .normal)
            tag = tag_
        case .map:
            titleLabel?.font = SeSacFont.Title3_M14.set
            backgroundColor = SeSacColor.white
            setTitle(title, for: .normal)
            setTitleColor(SeSacColor.black, for: .normal)
        case .search:
            backgroundColor = color
            titleLabel?.font = font_
            setTitle(title, for: .normal)
        case .settingTap:
            setTitle(title, for: .normal)
            setTitleColor(SeSacColor.gray6, for: .normal)
            titleLabel?.font = SeSacFont.Title3_M14.set
            backgroundColor = SeSacColor.white
            tag = tag_
        case .settingRequest:
            backgroundColor = SeSacColor.error
            setTitleColor(SeSacColor.white, for: .normal)
            setTitle(title, for: .normal)
            layer.cornerRadius = 8
            layer.masksToBounds = true
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureAttributes()
    }
    func configureAttributes() {
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

