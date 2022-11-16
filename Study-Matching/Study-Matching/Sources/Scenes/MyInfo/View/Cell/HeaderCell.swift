import UIKit
import SnapKit

class HeaderCell: BaseCollectionViewCell {
    
    var label: UILabel = {
        let view = UILabel()
        
        return view
    }()
    

    
    override func configureHierarchy() {
        addSubview(label)
        self.backgroundColor = .tintColor
    }
    
    override func configureLayout() {
        label.snp.makeConstraints {
            $0.edges.equalTo(self)
        }
        
    }

}
