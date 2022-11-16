import UIKit
import SnapKit

class TopStackView: UIStackView {
    
    let sectinLabel: UILabel = {
        let view = UILabel()
        view.text = "새싹 타이틀"
        return view
    }()
    
    let button1 = SeSacButton(title: "좋은매너")
    let button2 = SeSacButton(title: "정확한 시간 약속")
    let button3 = SeSacButton(title: "빠른 응답")
    let button4 = SeSacButton(title: "친절한 성격")
    let button5 = SeSacButton(title: "능숙한 실력")
    let button6 = SeSacButton(title: "유익한 시간")
    
    let leftVerticalStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.alignment = .fill
        stack.spacing = 6
        return stack
    }()
    
    let rightVerticalStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.alignment = .fill
        stack.spacing = 6
        return stack
    }()
    
    let totalStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.alignment = .fill
        stack.spacing = 6
        return stack
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureHierarchy()
        configureLayout()
        configureAttributes()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureHierarchy() {

        [sectinLabel, totalStackView].forEach{ addArrangedSubview($0) }
        
        [leftVerticalStackView, rightVerticalStackView].forEach { subView in
            totalStackView.addArrangedSubview(subView)
        }
        
        [button1, button2, button3].forEach { subView in
            leftVerticalStackView.addArrangedSubview(subView)
        }
        
        [button4, button5, button6].forEach { subView in
            rightVerticalStackView.addArrangedSubview(subView)
        }

    }
    
    func configureLayout() {
        totalStackView.snp.makeConstraints {
            $0.edges.equalTo(self)
        }
    }
    func configureAttributes() {
        self.axis = .vertical
        self.backgroundColor = .blue
    }
}
