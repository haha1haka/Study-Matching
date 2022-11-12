import UIKit
import RxSwift
import RxCocoa

class GenderViewController: BaseViewController {
    let selfView = GenderView()
    override func loadView() {
        view = selfView
    }
    
    let viewModel = GenderViewModel()
    
    let disposeBag = DisposeBag()
    
    var collectionViewDataSource: UICollectionViewDiffableDataSource<String, String>!
}

extension GenderViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        selfView.collectionView.delegate = self
        configureCollectionViewDataSource()
        applySnapshot()
    }
}

extension GenderViewController {
    func input() {
        
    }
    func output() {
        
    }
    func buttonRxTap() {
        
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

