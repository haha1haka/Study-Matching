import UIKit
import SnapKit

class SMSView: BaseView {

    let label = UILabel()
    let textFiled = SeSacTexField()
    let button = SeSacButton()
    
    
    override func configureHierarchy() {
        [label, textFiled, button].forEach { self.addSubview($0) }
    }
    
    override func configureLayout() {
        label.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(125)
            $0.leading.trailing.equalTo(self.safeAreaLayoutGuide).inset(74)
            $0.height.equalTo(64)
        }
        textFiled.snp.makeConstraints {
            $0.top.equalTo(label.snp.bottom).offset(64)
            $0.leading.trailing.equalTo(self.safeAreaLayoutGuide).inset(16)
            $0.height.equalTo(48)
        }
        button.snp.makeConstraints {
            $0.top.equalTo(textFiled.snp.bottom).offset(72)
            $0.leading.trailing.equalTo(self.safeAreaLayoutGuide).inset(16)
            $0.height.equalTo(48)
            
        }
    }
    
    override func configureAttributes() {
        
        
    
        label.numberOfLines = .zero
        label.textAlignment = .center
        label.font = SeSacFont.Display1_R20.set
        label.text = """
                    인증번호가 문자로 전송되었습니다
                    """
        
        textFiled.placeholder = "휴대폰 번호(-없이 숫자만 입력)"
        textFiled.tintColor = .clear
        
        
        button.setTitle("인증 문자 받기", for: .normal)
        
    }

}
