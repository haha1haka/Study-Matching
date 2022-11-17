import UIKit
import SnapKit

class StudyView: UIView {
    
    let studyLable: UILabel = {
        let label = UILabel()
        label.text = "자주 하는 스터디"
        label.font = SeSacFont.Title4_R14.set
        label.textColor = SeSacColor.black
        return label
    }()
    
    let studyTextField: SeSacTexField = {
        let view = SeSacTexField(title: "알고리즘")
        return view
    }()
    
    let totalStackView: UIStackView = {
        let stack = UIStackView()
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
        [studyLable, studyTextField].forEach { totalStackView.addArrangedSubview($0) }
    }
    
    
    func configureLayout() {
        totalStackView.snp.makeConstraints {
            $0.edges.equalTo(self)
        }
    }
    
    
}
