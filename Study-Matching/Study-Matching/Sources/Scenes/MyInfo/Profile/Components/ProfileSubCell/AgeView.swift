import UIKit
import SnapKit

class AgeView: UIView {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "상대방 연령대"
        label.font = SeSacFont.Title4_R14.set
        label.textColor = SeSacColor.black
        return label
    }()
    
    let ageLabel: UILabel = {
        let label = UILabel()
        label.text = "18 - 35"
        label.font = SeSacFont.Title3_M14.set
        label.textColor = SeSacColor.green
        return label
    }()
    
    let totalStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .fill
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
        [titleLabel, ageLabel].forEach { totalStackView.addArrangedSubview($0) }
    }
    
    func configureLayout() {
        totalStackView.snp.makeConstraints {
            $0.edges.equalTo(self)
        }
    }

    
}
