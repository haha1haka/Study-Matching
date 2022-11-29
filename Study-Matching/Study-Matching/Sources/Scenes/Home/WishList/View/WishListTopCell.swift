import UIKit
import SnapKit

class WishListTopCell: BaseCollectionViewCell {
    
    let label: UILabel = {
        let view = UILabel()
        view.font = SeSacFont.Title4_R14.set
        return view
    }()
    
    override func configureHierarchy() {
        addSubview(label)
    }
    override func configureLayout() {
        label.snp.makeConstraints {
            $0.top.bottom.equalTo(self).inset(5)
            $0.leading.trailing.equalTo(self).inset(16)
        }
    }
    
    
    override func configureAttributesInit() {
        layer.cornerRadius = 8
        layer.borderWidth = 1
        layer.masksToBounds = true
        
    }
    
    
    func configure(with item: Nearby) {
        label.text = item.label
        layer.borderColor = item.borderColor.cgColor
        label.textColor = item.titleColor
    }

}
