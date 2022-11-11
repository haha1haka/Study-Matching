import UIKit
import SnapKit

class OnboardCell: BaseCollectionViewCell {
    
    let labelImageView = UIImageView()
    let mainImageView = UIImageView()
    
    override func configureHierarchy() {
        [labelImageView, mainImageView].forEach { self.addSubview($0) }

    }
    override func configureLayout() {
        labelImageView.snp.makeConstraints {
            $0.top.equalTo(self)
            $0.leading.trailing.equalTo(self).inset(50)
            $0.height.equalTo(76)
        }
        mainImageView.snp.makeConstraints {
            $0.top.equalTo(labelImageView.snp.bottom).offset(56)
            $0.leading.trailing.equalTo(self).inset(8)
            $0.bottom.equalTo(self.safeAreaLayoutGuide).inset(8)
        }
    }
    
    override func configureAttributesInit() {
        
        labelImageView.contentMode = .scaleAspectFit
        mainImageView.contentMode = .scaleAspectFit
    }
    
    func configureAttributes(item: Page) {
        labelImageView.image = item.labelImage
        mainImageView.image = item.mainImage
        
        
        
    }
}
