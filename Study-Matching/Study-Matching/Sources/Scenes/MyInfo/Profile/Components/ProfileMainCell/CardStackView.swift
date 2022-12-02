import UIKit
import SnapKit

class CardStackView: UIStackView {
    
    
    let button0 = SeSacButton(title: "좋은매너", type: .myInfo, tag_: 0)
    let button2 = SeSacButton(title: "정확한 시간 약속", type: .myInfo, tag_: 1)
    let button4 = SeSacButton(title: "빠른 응답", type: .myInfo, tag_: 2)
    let button1 = SeSacButton(title: "친절한 성격", type: .myInfo, tag_: 3)
    let button3 = SeSacButton(title: "능숙한 실력", type: .myInfo, tag_: 4)
    let button5 = SeSacButton(title: "유익한 시간", type: .myInfo, tag_: 5)
    lazy var buttons = [button0, button1,button2,button3,button4,button5]
    let leftVerticalStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.alignment = .fill
        stack.spacing = 8
        return stack
    }()
    
    let rightVerticalStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.alignment = .fill
        stack.spacing = 8
        return stack
    }()
    
    let totalStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.alignment = .fill
        stack.spacing = 8
        return stack
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureHierarchy()
        configureLayout()
        //configureAttributes()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureHierarchy() {

        [totalStackView].forEach { subView in
            self.addSubview(subView)
        }
        
        [leftVerticalStackView, rightVerticalStackView].forEach { subView in
            totalStackView.addArrangedSubview(subView)
        }
        
        [button0, button2, button4].forEach { subView in
            leftVerticalStackView.addArrangedSubview(subView)
        }
        
        [button1, button3, button5].forEach { subView in
            rightVerticalStackView.addArrangedSubview(subView)
        }

    }
    func configureLayout() {
        totalStackView.snp.makeConstraints {
            $0.edges.equalTo(self)
        }

    }

}
