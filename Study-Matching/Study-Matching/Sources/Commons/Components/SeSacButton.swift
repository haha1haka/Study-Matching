import UIKit


class SeSacButton: UIButton {
    
    convenience init(frame: CGRect = .zero,
                     title: String,
                     color: UIColor = SeSacColor.gray6.set,
                     font_: UIFont = SeSacFont.Body3_R14.set)
    {
        self.init(frame: frame)
        titleLabel?.font = font_
        setTitle(title, for: .normal)
        backgroundColor = color
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


