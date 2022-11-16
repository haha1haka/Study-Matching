import UIKit
import SnapKit

class MyInfoHeaderView: UICollectionReusableView {
    
    let imageView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .systemPink
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
        addSubview(imageView)
    }
    
    func configureLayout() {
        imageView.snp.makeConstraints {
            $0.edges.equalTo(self)
        }
    }
    
    func configureAttributes() {
        layer.cornerRadius = 8
        layer.masksToBounds = true
    }

    
}





