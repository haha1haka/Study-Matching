import UIKit
import SnapKit

class EmailView: BaseView {

    let label = SeSacLabel(text_: "이메일을 입력해 주세요")
    let subLabel = SeSacLabel(text_: "휴대폰 번호 변경 시 인증을 위해 사용해요",
                              color: SeSacColor.gray7,
                              font_: SeSacFont.Title2_R16.set)
    let textFiled = SeSacTexField(title: "10자 이내로 입력")
    let button = SeSacButton(title: "다음")
    

    
    override func configureHierarchy() {
        [label, subLabel, textFiled, button].forEach { self.addSubview($0) }
    }
    
    override func configureLayout() {
        label.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(125)
            $0.leading.trailing.equalTo(self.safeAreaLayoutGuide).inset(74)
            $0.height.equalTo(64)
        }
        subLabel.snp.makeConstraints {
            $0.top.equalTo(label.snp.bottom)
            $0.leading.trailing.equalTo(self.safeAreaLayoutGuide).inset(50)
            $0.height.equalTo(26)
        }
        textFiled.snp.makeConstraints {
            $0.top.equalTo(subLabel.snp.bottom).offset(63)
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
