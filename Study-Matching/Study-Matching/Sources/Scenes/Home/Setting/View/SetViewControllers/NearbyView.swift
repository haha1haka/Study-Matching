import UIKit
import SnapKit

class NearbyView: BaseView {

    let imageView: UIImageView = {
        let view = UIImageView()
        view.image = SeSacImage.emptyImg
        return view
    }()
    let mainLable: UILabel = {
        let view = UILabel()
        view.text = "아쉽게도 주변에 새싹이 없어요ㅠ"
        
        return view
    }()
    let subLable: UILabel = {
        let view = UILabel()
        view.text = "스터디를 변경하거나 조금만 더 기다려 주세요!"
        return view
    }()

    override func configureHierarchy() {
        addSubview(imageView)
        addSubview(mainLable)
        addSubview(subLable)
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
    }
//    override func configureAttributes() {
//        <#code#>
//    }

}
