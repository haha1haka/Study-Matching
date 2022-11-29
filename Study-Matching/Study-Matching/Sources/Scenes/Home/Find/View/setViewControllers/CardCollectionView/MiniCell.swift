import UIKit
import SnapKit

class MiniCell: BaseCollectionViewCell {
    
    var label: UILabel = {
        let view = UILabel()
        return view
    }()
    
    override func configureHierarchy() {
        addSubview(label)
    }
    
    override func configureLayout() {
        label.snp.makeConstraints {
            $0.edges.equalTo(self).inset(10)
        }
    }
    
    //override func configureAttributesInit() {
    //    <#code#>
    //}
}
