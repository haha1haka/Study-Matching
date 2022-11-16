import UIKit
import SnapKit

class SwitchView: UIView {
    
    let switchLabel: UILabel = {
        let label = UILabel()
        label.text = "내 번호 검색 허용"
        label.font = SeSacFont.Title4_R14.set
        label.textColor = SeSacColor.black
        label.setContentHuggingPriority(.defaultLow, for: .horizontal)
        return label
    }()
    
    let switchUI: UISwitch = {
        let customSwitch = UISwitch()
        customSwitch.onTintColor = SeSacColor.green
        return customSwitch
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
        [switchLabel, switchUI].forEach { totalStackView.addArrangedSubview($0) }
    }
    
    
    func configureLayout() {
        totalStackView.snp.makeConstraints {
            $0.edges.equalTo(self)
        }
    }
}
