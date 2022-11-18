import UIKit
import SnapKit

class Gender2View: UIView {
    
    let genderLabel: UILabel = {
        let label = UILabel()
        label.text = "내 성별"
        label.font = SeSacFont.Title4_R14.set
        label.textColor = SeSacColor.black
        return label
    }()
    
    let manButton: SeSacButton = {
        let view = SeSacButton(title: "남자")
        
        return view
    }()
    
    let womanButton: SeSacButton = {
        let view = SeSacButton(title: "여자")
        
        return view
    }()
    
    let totalStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center
        return stack
    }()
    
    let buttonStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fillEqually
        stack.spacing = 7
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
        [manButton, womanButton].forEach { buttonStackView.addArrangedSubview($0) }
        
        [genderLabel, buttonStackView].forEach { totalStackView.addArrangedSubview($0) }
        
        self.addSubview(totalStackView)
    }
    
    func configureLayout() {
        totalStackView.snp.makeConstraints {
            $0.edges.equalTo(self)
        }
        
        buttonStackView.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.33)
            $0.height.equalTo(buttonStackView.snp.width).multipliedBy(0.4)
        }
    }
    

}

