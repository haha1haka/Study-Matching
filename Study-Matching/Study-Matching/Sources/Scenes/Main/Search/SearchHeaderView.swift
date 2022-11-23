import UIKit
import SnapKit

class SearchHeaderView: UICollectionReusableView {
    
    let sectionLabel: UILabel = {
        let view = UILabel()
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureHierarcy()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureHierarcy() {
        addSubview(sectionLabel)
    }
    
    func configureLayout() {
        sectionLabel.snp.makeConstraints {
            $0.edges.equalTo(self)
        }
    }

}





