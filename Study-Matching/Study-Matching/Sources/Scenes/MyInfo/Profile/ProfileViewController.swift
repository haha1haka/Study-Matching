import UIKit





class ProfileViewController: BaseViewController {
    
    let selfView = ProfileView()
    override func loadView() {
        view = selfView
    }
    lazy var dataSource = ProfileDataSource(collectionView: selfView.collectionView)

    
}

extension ProfileViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource.applyInitialSnapshot()
        selfView.collectionView.delegate = self
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
