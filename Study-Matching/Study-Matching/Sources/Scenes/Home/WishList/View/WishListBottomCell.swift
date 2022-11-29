import UIKit
import SnapKit

class WishListBottomCell: BaseCollectionViewCell {
    
    lazy var totalStackView: UIStackView = {
        let view = UIStackView(
        arrangedSubviews: [
                label,button
            ])
        view.axis = .horizontal
        view.distribution = .fill
        view.spacing = 6.75
        return view
    }()
    
    let label: UILabel = {
        let view = UILabel()
        view.textColor = SeSacColor.green
        view.font = SeSacFont.Title4_R14.set
        return view
    }()
    let button: UIButton = {
        let view = UIButton(type: .custom)
        view.setImage(SeSacImage.closeSmall?.withRenderingMode(.alwaysTemplate), for: .normal)
        view.tintColor = SeSacColor.green
        return view
    }()
    
    override func configureHierarchy() {
        addSubview(totalStackView)
    }
    
    override func configureLayout() {
        totalStackView.snp.makeConstraints {
            $0.top.bottom.equalTo(self).inset(5)
            $0.leading.trailing.equalTo(self).inset(16)
        }

        
    }
    override func configureAttributesInit() {
        layer.cornerRadius = 8
        layer.borderWidth = 1
        layer.masksToBounds = true
        layer.borderColor = SeSacColor.green.cgColor
        
        
        
    }
    func configure(with item: Wanted) {
        label.text = item.label
        
    }
}

