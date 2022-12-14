import UIKit
import SnapKit

class NicknameView: BaseView {

    let label = SeSacLabel(text_: "닉네임을 입력해 주세요")
    let textFiled = SeSacTexField(title: "10자 이내로 입력")
    let button = SeSacButton(title: "다음")

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


}
