import UIKit
import SnapKit

class SplashView: BaseView {

    
    let logoMainImage: UIImageView = {
        let view = UIImageView()
        view.image = SeSacImage.splashLogo
        return view
    }()
    
    let logoTextImage: UIImageView = {
        let view = UIImageView()
        view.image = SeSacImage.splashTxt
        return view
    }()
    
    
    

    override func configureHierarchy() {
        [logoMainImage, logoTextImage].forEach{ self.addSubview($0) }
    }
    
    override func configureLayout() {
        logoMainImage.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(175)
            $0.leading.trailing.equalTo(self.safeAreaLayoutGuide).inset(78)
            $0.bottom.equalTo(self).inset(333)
                
        }
        logoTextImage.snp.makeConstraints {
            $0.top.equalTo(logoMainImage.snp.bottom).offset(35)
            $0.leading.trailing.equalTo(self.safeAreaLayoutGuide).inset(41)
            $0.bottom.equalTo(self).inset(197)
        }
    }


}


