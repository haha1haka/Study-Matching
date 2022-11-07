import UIKit


class SeSacButton: UIButton {
    
    
    convenience init(frame: CGRect, title: String) {
        self.init(frame: frame)
        setTitle(title, for: .normal)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureAttributes()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureAttributes() {
        backgroundColor = UIColor(named: "green")
        
        
    }
    
}
