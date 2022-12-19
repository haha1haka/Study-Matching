import UIKit
import SnapKit

class WithDrawView: UIView {
    
    let withdrawButton: UIButton = {
        let button = UIButton()
        button.setTitle("회원탈퇴", for: .normal)
        button.titleLabel?.font = SeSacFont.Title4_R14.set
        button.setTitleColor(SeSacColor.black, for: .normal)
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureHierarcy()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureHierarcy() {
        addSubview(withdrawButton)
    }
    
    func configureLayout() {
        withdrawButton.snp.makeConstraints {
            $0.leading.equalTo(self)
            $0.centerY.equalTo(self.snp.centerY)
        }
    }
}
