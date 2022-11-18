import UIKit
import RxSwift
import RxCocoa

class ProfileViewController: BaseViewController {
    
    let selfView = ProfileView()
    override func loadView() {
        view = selfView
    }
    
    var mainCellRegistration: UICollectionView.CellRegistration<ProfileMainCell, UserMainDTO>?
    var subcCellRegistration: UICollectionView.CellRegistration<ProfileSubCell, UserSubDTO>?

    lazy var dataSource = ProfileDataSource(collectionView: selfView.collectionView, self.mainCellRegistration!, self.subcCellRegistration!)
    
    let viewModel = MyInfoViewModel()
    let disposeBag = DisposeBag()
    
}

extension ProfileViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        registeredCell()
        dataSource.applyInitialSnapshot(firstSectionData: viewModel.userMainDTO!, secondSectionData: viewModel.userSubDTO!)
        selfView.collectionView.delegate = self
    }
}

extension ProfileViewController {
    func setData() {

    }
}



extension ProfileViewController {
    func registeredCell() {
        mainCellRegistration = UICollectionView.CellRegistration<ProfileMainCell,UserMainDTO> { cell, indexPath, itemIdentifier in
            
            
        }
        
        
        subcCellRegistration = UICollectionView.CellRegistration<ProfileSubCell,UserSubDTO> { cell, indexPath, itemIdentifier in
            //viewModel.gender.bind(to: cell.genderView.manButton)
                
            
                
                    
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
