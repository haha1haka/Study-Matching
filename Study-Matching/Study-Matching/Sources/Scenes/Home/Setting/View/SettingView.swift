import UIKit
import SnapKit

class SettingView: BaseView {

    lazy var topStackView: UIStackView = {
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
    

    let nearbyButton = SeSacButton(title: "주변새싹",type: .settingTap , tag_: .zero)
    let requestedButton = SeSacButton(title: "받은요청",type: .settingTap ,tag_: 1)
    
    let dividerView1: UIView = {
        let view = UIView()
        view.backgroundColor = SeSacColor.gray2
        return view
    }()

    
\
    
    let dividerView2: UIView = {
        let view = UIView()
        view.backgroundColor = SeSacColor.gray2
        return view
    }()
    

    
    
    
    

    override func configureHierarchy() {
        addSubview(topStackView)
        
    }
    override func configureLayout() {
        topStackView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(self.safeAreaLayoutGuide)
            $0.height.equalTo(44)
        }
        
        dividerView1.snp.makeConstraints {
            $0.height.equalTo(1)
        }
        dividerView2.snp.makeConstraints {
            $0.height.equalTo(1)
        }
        

    }


}
