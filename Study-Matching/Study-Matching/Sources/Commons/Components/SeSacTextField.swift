import UIKit
import SnapKit

class SeSacTexField: UITextField {
    
    let dividerView: UIView = {
        let view = UIView()
        return view
    }()
    
    convenience init(frame: CGRect = .zero, title: String, font_: UIFont = SeSacFont.Title4_R14.set) {
        self.init(frame: frame)
        font = font_
        placeholder = title
    }
    
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
        backgroundColor = .clear
        
        dividerView.backgroundColor = SeSacColor.gray3
    }
    
}

