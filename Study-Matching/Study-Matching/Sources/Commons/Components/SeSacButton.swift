import UIKit
enum SeSacButtonType {
    case login
    case myInfo
}

class SeSacButton: UIButton {
    
    convenience init(frame: CGRect = .zero,
                     title: String,
                     color: UIColor = SeSacColor.gray6,
                     font_: UIFont = SeSacFont.Body3_R14.set,
                     type: SeSacButtonType = .login,
                     tag_: Int = .zero)
                     
    {
        self.init(frame: frame)

        switch type {
        case .login:
            backgroundColor = color
            titleLabel?.font = font_
            setTitle(title, for: .normal)
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
        }
                

    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureAttributes()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SeSacButton {
    func configureAttributes() {
        layer.cornerRadius = 8
        layer.masksToBounds = true
    }
}


