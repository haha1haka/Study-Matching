import UIKit
import SnapKit

class ChatHeaderView: UICollectionReusableView {

    let dateLabel: SeSacLabel = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko")
        formatter.dateFormat = "M월 dd일 E요일"
        let today = Date()
        let view = SeSacLabel(text_: formatter.string(from: today), color: SeSacColor.white, font_: SeSacFont.Title5_M12.set)
        view.backgroundColor = SeSacColor.gray7
        view.toRadius
        return view
    }()
    
    lazy var stackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [
            imageView, mainLabel
        ])
        view.axis = .horizontal
        return view
    }()
    
    var imageView: UIImageView = {
        let view = UIImageView()
        view.image = SeSacImage.bell
        return view
    }()
    
    let mainLabel: SeSacLabel = {
        let view = SeSacLabel(
            text_:"\(UserDefaultsManager.standard.matchedNick)님과 매칭 되었습니다",
            color: SeSacColor.gray7,
            font_: SeSacFont.Title3_M14.set
        )
        return view
    }()
    
    let subLabel: SeSacLabel = {
        let view = SeSacLabel(
            text_: "채팅을 통해 약속을 정해보세요",
            color: SeSacColor.gray6,
            font_: SeSacFont.Title4_R14.set
        )
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
        addSubview(dateLabel)
        addSubview(stackView)
        addSubview(subLabel)
    }
    
    func configureLayout() {

        dateLabel.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(16)
            $0.leading.trailing.equalTo(self).inset(120)
            $0.height.equalTo(28)
        }
        
        stackView.snp.makeConstraints {
            $0.top.equalTo(dateLabel.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview().inset(70)
            $0.height.equalTo(22)
        }
        
        imageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(3)
            $0.bottom.equalToSuperview().inset(3)
            $0.width.height.equalTo(16)
        }
        
        subLabel.snp.makeConstraints {
            $0.top.equalTo(stackView.snp.bottom).offset(2)
            $0.leading.trailing.equalTo(self).inset(70)
            $0.height.equalTo(22)
        }
    }
    
    func configureAttributes() {
        layer.cornerRadius = 8
        layer.masksToBounds = true
    }
}





