import UIKit
import SnapKit

class SearchBottomCell: BaseCollectionViewCell {
    
    lazy var totalStackView: UIStackView = {
        let view = UIStackView(
        arrangedSubviews: [
                label,button
            ])
        view.axis = .horizontal
        view.distribution = .fillProportionally
        return view
    }()
    
    let label: UILabel = {
        let view = UILabel()
        return view
    }()
    let button: UIButton = {
        let view = UIButton()
        return view
    }()
    
    override func configureHierarchy() {
        addSubview(totalStackView)
    }
    
    override func configureLayout() {
        totalStackView.snp.makeConstraints {
            $0.edges.equalTo(self).inset(5)
        }
        
    }
}
