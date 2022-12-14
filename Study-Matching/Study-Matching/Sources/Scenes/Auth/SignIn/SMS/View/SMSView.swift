import UIKit
import SnapKit

class SMSView: BaseView {

    let label = SeSacLabel(text_: "인증번호가 문자로 전송되었어요")
    let textFiled = SeSacTexField(title: "휴대폰 번호(-없이 숫자만 입력)")
    let reSandButton = SeSacButton(title: "재전송", color: SeSacColor.green)
    let button = SeSacButton(title: "인증하고 시작하기")
    
    override func configureHierarchy() {
        [label, textFiled, reSandButton, button].forEach { self.addSubview($0) }
    }
    
    override func configureLayout() {
        label.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(125)
            $0.leading.trailing.equalTo(self.safeAreaLayoutGuide).inset(74)
            $0.height.equalTo(64)
        }
        textFiled.snp.makeConstraints {
            $0.top.equalTo(label.snp.bottom).offset(64)
            $0.leading.equalTo(self.safeAreaLayoutGuide).inset(16)
            $0.width.equalTo(270)
            $0.height.equalTo(48)
        }
        reSandButton.snp.makeConstraints {
            $0.trailing.equalTo(self.safeAreaLayoutGuide).inset(16)
            $0.leading.equalTo(textFiled.snp.trailing).offset(8)
            $0.centerY.equalTo(textFiled.snp.centerY)
            $0.height.equalTo(40)
        }
        
        button.snp.makeConstraints {
            $0.top.equalTo(textFiled.snp.bottom).offset(72)
            $0.leading.trailing.equalTo(self.safeAreaLayoutGuide).inset(16)
            $0.height.equalTo(48)
        }
    }
}
