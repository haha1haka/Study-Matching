import UIKit
import RxSwift
import RxCocoa

class ProfileViewController: BaseViewController {
    
    let selfView = ProfileView()
    override func loadView() {
        view = selfView
    }
    
    var mainCellRegistration: UICollectionView.CellRegistration<ProfileMainCell, MemoleaseUser>?
    var subcCellRegistration: UICollectionView.CellRegistration<ProfileSubCell, MemoleaseUser>?

    lazy var dataSource = ProfileDataSource(
        collectionView: selfView.collectionView,
        self.mainCellRegistration!,
        self.subcCellRegistration!)
    
    let viewModel = MyInfoViewModel.shared
    let disposeBag = DisposeBag()
    
}

extension ProfileViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        registeredCell()
        applyInitialSnapshot()
        selfView.collectionView.delegate = self
    }
    
    func applyInitialSnapshot() {
        var snapshot = dataSource.snapshot()
        snapshot.appendSections([0, 1])
        snapshot.appendItems([Item.main(viewModel.user.value!)])
        snapshot.appendItems([Item.sub(viewModel.user.value!)])
        dataSource.apply(snapshot)
    }
}

extension ProfileViewController {
    func setData() {

    }
}



extension ProfileViewController {
    func registeredCell() {
        mainCellRegistration = UICollectionView.CellRegistration<ProfileMainCell,MemoleaseUser> { cell, indexPath, itemIdentifier in
            
            
        }
        
        
        subcCellRegistration = UICollectionView.CellRegistration<ProfileSubCell,MemoleaseUser> { cell, indexPath, itemIdentifier in
            
                
            
                
                    
        }
    }

}

extension ProfileViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {

        if collectionView.indexPathsForSelectedItems?.contains(indexPath) ?? false {
            collectionView.deselectItem(at: indexPath, animated: true)
        } else {
            collectionView.selectItem(at: indexPath, animated: true, scrollPosition: [])
        }
        
        dataSource.refresh()
        
        return false
    }
    
}

extension UICollectionViewDiffableDataSource {
    typealias CellRegistraion = UICollectionView.CellRegistration
}
