import UIKit
import SnapKit

class ChatLeftCell: BaseCollectionViewCell {
    
//    lazy var stackView: UIStackView = {
//        let view = UIStackView(arrangedSubviews: [
//            label, dateLabel
//        ])
//        view.spacing = 8
//        view.axis = .horizontal
//        view.distribution = .fillProportionally
//        return view
//    }()
    
    let label: UILabel = {
        let view = UILabel()
        view.layer.cornerRadius = 8
        view.layer.masksToBounds = true
        view.backgroundColor = .white
        view.font = SeSacFont.Body3_R14.set
        view.layer.borderColor = SeSacColor.gray4.cgColor
        //view.numberOfLines = 0
        view.layer.borderWidth = 1
        return view
    }()
    
    let dateLabel: UILabel = {
        let view = UILabel()
        view.textColor = SeSacColor.gray6
        view.font = SeSacFont.Title6_R12.set
        view.text = "15:02"
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
        addSubview(label)
        addSubview(dateLabel)
    }
    
    override func configureLayout() {
        label.snp.makeConstraints {
            $0.top.bottom.equalTo(contentView)
            
            $0.leading.equalTo(self.snp.leading)
            
        }
        dateLabel.snp.makeConstraints {
            $0.leading.equalTo(label.snp.trailing).offset(8)
            
            $0.bottom.equalTo(label.snp.bottom)
        }

    }

}
