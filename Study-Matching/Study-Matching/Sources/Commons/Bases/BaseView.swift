import UIKit

class BaseView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = SeSacColor.white.set
        configureAttributes()
        configureHierarchy()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureAttributes() {}
    func configureHierarchy() {}
    func configureLayout() {}
    
}
