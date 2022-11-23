import UIKit
import SnapKit

class SearchTopCell: BaseCollectionViewCell {
    
    let label: UILabel = {
        let view = UILabel()
        
        return view
    }()
    
    override func configureHierarchy() {
        addSubview(label)
    }
    override func configureLayout() {
        label.snp.makeConstraints {
            $0.edges.equalTo(self).inset(5)
        }
    }
    
    
    override func configureAttributesInit() {
        layer.cornerRadius = 8
        layer.borderColor = SeSacColor.gray3.cgColor
        layer.borderWidth = 1
        layer.masksToBounds = true
    }
    
    
    func configure(with item: Top) {
        label.text = item.label
    }

}
