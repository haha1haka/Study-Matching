import UIKit
import SnapKit

class ChatRightCell: BaseCollectionViewCell {
    
    lazy var stackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [
            dateLabel, label
        ])
        view.spacing = 8
        view.axis = .horizontal
        view.distribution = .fillProportionally
        return view
    }()
    
    let dateLabel: UILabel = {
        let view = UILabel()
        view.textColor = SeSacColor.gray6
        view.text = "15:02"
        view.font = SeSacFont.Title6_R12.set
        return view
    }()
    
    let label: UILabel = {
        let view = UILabel()
        view.layer.cornerRadius = 8
        view.layer.masksToBounds = true
        view.backgroundColor = .white
        view.font = SeSacFont.Body3_R14.set
        view.layer.borderColor = SeSacColor.gray4.cgColor
        view.layer.borderWidth = 1
        view.textAlignment = .right
        return view
    }()
    

    
    
//    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
//        let attributes = super.preferredLayoutAttributesFitting(layoutAttributes)
//        guard let photoItem = photoItem else { return attributes }
//        let ratio = CGFloat(photoItem.height) / CGFloat(photoItem.width)
//        let newHeight = attributes.bounds.width * ratio
//        attributes.bounds.size.height = newHeight
//        return attributes
//    }
    
    override func configureHierarchy() {
        addSubview(dateLabel)
        addSubview(label)
    }
    
    override func configureLayout() {
        label.snp.makeConstraints {
            $0.top.bottom.equalTo(contentView)
            $0.trailing.equalTo(self.snp.trailing)
            $0.leading.equalTo(dateLabel.snp.trailing).offset(8)
        }
        
        dateLabel.snp.makeConstraints {
            $0.bottom.equalTo(label.snp.bottom)
        }
        

    }

}
