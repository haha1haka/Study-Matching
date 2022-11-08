import UIKit
import SnapKit

class SeSacTexField: UITextField {
    
    let dividerView: UIView = {
        let view = UIView()
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureHierarcy()
        configureLayout()
        configureAttributes()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension SeSacTexField {
    
    func configureHierarcy() {
        self.addSubview(dividerView)
    }
    func configureLayout() {
        dividerView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalTo(self)
            $0.height.equalTo(1)
        }
    }
    
    func configureAttributes() {
        self.backgroundColor = .clear
        dividerView.backgroundColor = .opaqueSeparator
    }
    
}
