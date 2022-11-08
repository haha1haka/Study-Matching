import UIKit
import SnapKit

class GenderViewController: BaseViewController {
    let selfView = GenderView()
    override func loadView() {
        view = selfView
    }
    var collectionViewDataSource: UICollectionViewDiffableDataSource<String, String>!
}

extension GenderViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionViewDataSource()
        applySnapshot()
    }
}
extension GenderViewController {
    
    func configureCollectionViewDataSource() {
        
        let CellRegistration = UICollectionView.CellRegistration<GenderCell,String> { cell, indexPath, itemIdentifier in
            switch indexPath.item {
            case .zero:
                cell.imageView.image = UIImage(named: "man")
            default:
                cell.imageView.image = UIImage(named: "woman")
            }
            
        }
        
        collectionViewDataSource = UICollectionViewDiffableDataSource<String, String>(collectionView: selfView.collectionView) {
            collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: CellRegistration, for: indexPath, item: itemIdentifier)
            return cell
        }
    }
    
    func applySnapshot() {
        var snapshot = collectionViewDataSource.snapshot()
        snapshot.appendSections(["첫번째"])
        snapshot.appendItems(["1", "2"])
        collectionViewDataSource.apply(snapshot)
    }

}

extension GenderViewController {

}

class GenderCell: BaseCollectionViewCell {

    let imageView: UIImageView = {
        let view = UIImageView()
        return view
    }()
    
    override var isSelected: Bool {
        didSet {
            isSelectedCell()
        }
    }
    
    func isSelectedCell() {
        if isSelected {
            imageView.backgroundColor = SeSacColor.whitegreen.set
        } else {
            imageView.backgroundColor = SeSacColor.white.set
        }
        
        
    }
    
    override func configureHierarchy() {
        self.addSubview(imageView)
    }
    override func configureLayout() {
        imageView.snp.makeConstraints {
            $0.edges.equalTo(self)
        }
    }

}
