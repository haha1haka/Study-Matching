import UIKit


class SeSacButton: UIButton {
    
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
        backgroundColor = SeSacColor.gray6.set
        layer.cornerRadius = 8
        layer.masksToBounds = true
    }
}
