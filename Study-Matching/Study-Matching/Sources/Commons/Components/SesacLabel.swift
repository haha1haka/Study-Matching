import UIKit


class SeSacLabel: UILabel {
    
    convenience init(frame: CGRect = .zero, text_: String, font_: UIFont) {
        self.init(frame: frame)
        font = font_
        text = text_
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureAttributes()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SeSacLabel {
    func configureAttributes() {
        numberOfLines = .zero
        textAlignment = .center
    }
}

