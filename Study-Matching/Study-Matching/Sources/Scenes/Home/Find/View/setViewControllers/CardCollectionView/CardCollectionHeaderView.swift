import UIKit
import SnapKit

class CardCollectionHeaderView: UICollectionReusableView {
    
    let mainImageView: UIImageView = {
        let view = UIImageView()
        
        return view
    }()
    let subImageView: UIImageView = {
        let view = UIImageView()
        
        return view
    }()
    
    let requestButton = SeSacButton(title: "요청하기")
    
    
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
        addSubview(mainImageView)
        addSubview(requestButton)
        mainImageView.addSubview(subImageView)
    }
    
    func configureLayout() {
        mainImageView.snp.makeConstraints {
            $0.edges.equalTo(self)
        }
        subImageView.snp.makeConstraints {
            $0.center.equalTo(mainImageView.snp.center)
        }
        requestButton.snp.makeConstraints {
            $0.top.trailing.equalTo(self).inset(12)
            $0.width.equalTo(80)
            $0.height.equalTo(40)
        }
    }
    
    func configureAttributes() {
        layer.cornerRadius = 8
        layer.masksToBounds = true
    }

    
}





