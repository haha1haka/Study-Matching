import UIKit
import SnapKit

class MyInfoCell: BaseCollectionViewCell {
    
    let imageView: UIImageView = {
        let view = UIImageView()
        return view
    }()
    
    let label: UILabel = {
        let view = UILabel()
        view.font = SeSacFont.Title2_R16.set
        return view
    }()
    
    let dividerView: UIView = {
        let view = UIView()
        view.backgroundColor = SeSacColor.gray3
        return view
    }()
    
    override func configureHierarchy() {
        [imageView, label, dividerView].forEach { addSubview($0) }
    }
    
    override func configureLayout() {
        imageView.snp.makeConstraints {
            $0.leading.equalTo(20)
            $0.centerY.equalTo(self.snp.centerY)
        }
        label.snp.makeConstraints {
            $0.leading.equalTo(imageView.snp.trailing).offset(15)
            $0.centerY.equalTo(self.snp.centerY)
        }
        dividerView.snp.makeConstraints {
            $0.leading.trailing.equalTo(self).inset(17)
            $0.bottom.equalTo(self)
            $0.height.equalTo(1)
        }
    }
    
    func configure(with item: Setting) {
        imageView.image = item.image
        label.text = item.label
    }
    
    
    

}
