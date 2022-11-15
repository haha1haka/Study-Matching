import UIKit
import SnapKit

class HeaderCell: BaseCollectionViewCell {
    
    lazy var collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: configureCollectionViewLayout())
        view.backgroundColor = .tintColor
        return view
    }()
    
    func configureCollectionViewLayout() -> UICollectionViewLayout {
        return UICollectionViewLayout()
    }
    
    override func configureHierarchy() {
        addSubview(collectionView)
    }
    override func configureLayout() {
        collectionView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(self)
            $0.height.equalTo(200)
        }
    }

}
