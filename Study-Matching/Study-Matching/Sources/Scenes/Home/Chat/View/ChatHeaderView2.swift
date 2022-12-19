import UIKit
import SnapKit

class ChatHeaderView2: UICollectionReusableView {
    
    let subLabel: SeSacLabel = {
        let view = SeSacLabel(
            text_: "여기까지 읽었어요😁",
            color: SeSacColor.gray6,
            font_: SeSacFont.Title4_R14.set)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureHierarcy()
        configureLayout()
        configureAttributes()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureHierarcy() {
        addSubview(subLabel)
    }
    
    func configureLayout() {
        subLabel.snp.makeConstraints {
            $0.centerY.equalTo(self.snp.centerY)
            $0.leading.trailing.equalTo(self).inset(70)
            $0.height.equalTo(22)
        }
    }
    
    func configureAttributes() {
        layer.cornerRadius = 8
        layer.masksToBounds = true
    }
}





