import UIKit
import RxSwift
import RxCocoa

class ProfileViewController: BaseViewController {
    
    let selfView = ProfileView()
    override func loadView() {
        view = selfView
    }
    
    var mainCellRegistration: UICollectionView.CellRegistration<ProfileMainCell, Main>?
    var subcCellRegistration: UICollectionView.CellRegistration<ProfileSubCell, Sub>?

    lazy var dataSource = ProfileDataSource(collectionView: selfView.collectionView, self.mainCellRegistration!, self.subcCellRegistration!)
    
    let viewModel = MyInfoViewModel()
    let disposeBag = DisposeBag()
    
}

extension ProfileViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        registeredCell()
        dataSource.applyInitialSnapshot()
        selfView.collectionView.delegate = self
    }
}

extension ProfileViewController {
    func registeredCell() {
        mainCellRegistration = UICollectionView.CellRegistration<ProfileMainCell,Main> { cell, indexPath, itemIdentifier in
            
            
        }
        
        
        subcCellRegistration = UICollectionView.CellRegistration<ProfileSubCell,Sub> { cell, indexPath, itemIdentifier in
            //cell.genderView.manButton.rx.tap
                    
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
