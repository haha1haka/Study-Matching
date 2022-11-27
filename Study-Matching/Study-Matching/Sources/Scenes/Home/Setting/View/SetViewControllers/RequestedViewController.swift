import UIKit

class RequestedViewController: BaseViewController, DataSourceRegistration {
    
    let selfView = RequestedView()
    
    override func loadView() { view = selfView }
    
    var header: RequestedHeadRegistration?
    var mainCell: RequestedCellRegistration?
    
    lazy var dataSource = RequestedDataSource(
        collectionView      : selfView.collectionView,
        headerRegistration  : self.header!,
        mainCellRegistration: self.mainCell!)
}

extension RequestedViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        selfView.collectionView.delegate = self
        dataSource.applySnapshot()
    }
}

extension RequestedViewController {
    func bind() {
        header = RequestedHeadRegistration (elementKind: UICollectionView.elementKindSectionHeader)
        { [weak self] supplementaryView, elementKind, indexPath in
            guard let self = self else { return }
        
        }
        
        mainCell = RequestedCellRegistration
        { [weak self] cell, indexPath, itemIdentifier in
            guard let self = self else { return }
    
        }
    }
}
extension RequestedViewController: UICollectionViewDelegate {
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
