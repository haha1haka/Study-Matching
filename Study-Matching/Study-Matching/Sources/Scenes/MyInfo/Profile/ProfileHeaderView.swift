import UIKit
import SnapKit

class ProfileHeaderView: UICollectionReusableView {
    
    let mainImageView: UIImageView = {
        let view = UIImageView()
        
        return view
    }()
    let subImageView: UIImageView = {
        let view = UIImageView()
        
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
        addSubview(mainImageView)
        mainImageView.addSubview(subImageView)
    }
    
    func configureLayout() {
        mainImageView.snp.makeConstraints {
            $0.edges.equalTo(self)
        }
        subImageView.snp.makeConstraints {
            $0.center.equalTo(mainImageView.snp.center)
        }
    }
    
    func configureAttributes() {
        layer.cornerRadius = 8
        layer.masksToBounds = true
    }

    
}





