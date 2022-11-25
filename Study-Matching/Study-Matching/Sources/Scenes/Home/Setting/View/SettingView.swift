import UIKit
import SnapKit

class SettingView: BaseView {

    lazy var totalStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [
            leftStackView, rightStackView
        ])
        view.axis = .horizontal
        view.distribution = .fillEqually
        return view
    }()
    
    lazy var leftStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [
            nearbyButton,
            dividerView1
        ])
        view.axis = .vertical
        return view
    }()
    
    lazy var rightStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [
            requestedButton,
            dividerView2
        ])
        view.axis = .vertical
        return view
    }()
    
    let nearbyButton: UIButton = {
        let view = UIButton()
        view.setTitle("주변새싹", for: .normal)
        view.setTitleColor(SeSacColor.gray6, for: .normal)
        view.titleLabel?.font = SeSacFont.Title3_M14.set
        return view
    }()
    let dividerView1: UIView = {
        let view = UIView()
        view.backgroundColor = SeSacColor.gray2
        return view
    }()

    
    let requestedButton: UIButton = {
        let view = UIButton()
        view.setTitle("받은요청", for: .normal)
        view.setTitleColor(SeSacColor.gray6, for: .normal)
        view.titleLabel?.font = SeSacFont.Title3_M14.set
        return view
    }()
    
    let dividerView2: UIView = {
        let view = UIView()
        view.backgroundColor = SeSacColor.gray2
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
        addSubview(totalStackView)
        addSubview(bottomTotalStackView)
    }
    override func configureLayout() {
        totalStackView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(self.safeAreaLayoutGuide)
            $0.height.equalTo(44)
        }
        
        dividerView1.snp.makeConstraints {
            $0.height.equalTo(1)
        }
        dividerView2.snp.makeConstraints {
            $0.height.equalTo(1)
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


}
