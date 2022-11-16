import UIKit
import SnapKit

class MiddleStackView: UIStackView {
    
    let sectinLabel: UILabel = {
        let view = UILabel()
        view.text = "새싹 리뷰"
        return view
    }()
    
    
    let reviewTextView: UITextView = {
        let view = UITextView()
        view.text = "첫 리뷰를 기다리는 중이예요!"
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureHierarchy()
        configureLayout()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureHierarchy() {
        axis = .vertical
        [sectinLabel, reviewTextView].forEach { addArrangedSubview($0) }
        
    }
    
    func configureLayout() {

    }
}
