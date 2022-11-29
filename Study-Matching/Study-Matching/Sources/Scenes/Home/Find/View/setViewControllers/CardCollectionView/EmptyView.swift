import UIKit
import SnapKit

class EmptyView: BaseView {

    let imageView: UIImageView = {
        let view = UIImageView()
        view.image = SeSacImage.emptyImg
        return view
    }()
    
    let mainLable: UILabel = {
        let view = UILabel()
        view.text = "아쉽게도 주변에 새싹이 없어요ㅠ"
        view.font = SeSacFont.Display1_R20.set
        view.textAlignment = .center
        return view
    }()
    
    let subLable: UILabel = {
        let view = UILabel()
        view.text = "스터디를 변경하거나 조금만 더 기다려 주세요!"
        view.textAlignment = .center
        view.font = SeSacFont.Title4_R14.set
        view.textColor = SeSacColor.gray7
        return view
    }()
    
    lazy var bottomTotalStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [
            searchButton, refreshButton
        ])
        view.axis = .horizontal
        view.spacing = 8
        view.distribution = .fillProportionally
        return view
    }()
    
    let searchButton: SeSacButton = {
        let view = SeSacButton(title: "스터디 변경하기", color: SeSacColor.green)
        return view
    }()
    let refreshButton: UIButton = {
        let view = UIButton()
        view.setImage(SeSacImage.btRefresh, for: .normal)
        return view
    }()
    

    override func configureHierarchy() {
        self.backgroundColor = .orange
        addSubview(imageView)
        addSubview(mainLable)
        addSubview(subLable)
        addSubview(bottomTotalStackView)
    }
    
    override func configureLayout() {
        imageView.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.22)
            $0.height.equalTo(imageView.snp.width)
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().multipliedBy(0.63)
        }
        
        mainLable.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(30)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(imageView.snp.bottom).offset(40)
        }
        
        subLable.snp.makeConstraints {
            $0.leading.trailing.equalTo(mainLable)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(mainLable.snp.bottom).offset(8)
        }
        bottomTotalStackView.snp.makeConstraints {
            $0.leading.trailing.equalTo(self.safeAreaLayoutGuide).inset(16)
            $0.bottom.equalTo(self).inset(50)
            $0.height.equalTo(48)
        }
        searchButton.snp.makeConstraints {
            $0.width.equalTo(287)
        }
    }
//    override func configureAttributes() {
//        <#code#>
//    }

}
