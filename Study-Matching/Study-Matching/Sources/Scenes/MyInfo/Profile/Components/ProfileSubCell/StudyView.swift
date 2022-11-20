import UIKit
import SnapKit

class StudyView: UIView {
    
    let studyLable: UILabel = {
        let label = UILabel()
        label.text = "자주 하는 스터디"
        label.font = SeSacFont.Title4_R14.set
        label.textColor = SeSacColor.black
        label.setContentHuggingPriority(.defaultLow, for: .horizontal)
        return label
    }()
    
    let studyTextField: SeSacTexField = {
        let view = SeSacTexField(title: "알고리즘")
        return view
    }()
    
    lazy var totalStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
            studyLable,studyTextField
        ])
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .fillEqually
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureHierarchy()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureHierarchy() {
        addSubview(totalStackView)
    }
    
    
    func configureLayout() {
        totalStackView.snp.makeConstraints {
            $0.edges.equalTo(self)
        }
    }
    
    
}
