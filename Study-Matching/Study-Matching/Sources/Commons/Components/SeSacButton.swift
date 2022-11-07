import UIKit


class SeSacButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(named: "green")
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
