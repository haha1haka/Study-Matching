import UIKit

//망한코드
enum Item: Hashable {
    case header(Header)
    case sub(Sub)
}
struct Header: Hashable {
    var title: String
}

struct Sub: Hashable {
    var title: String
}



class ProfileViewController: BaseViewController {
    
    let selfView = ProfileView()
    
    override func loadView() {
        view = selfView
    }
    
    let headerData = [Header(title: "안녕")]
    let subData = [Sub(title: "hi")]
    
    var collectionViewDataSource: UICollectionViewDiffableDataSource<Int, Item>!
    
}

extension ProfileViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionViewDataSource()
        applySnapshot()
        selfView.collectionView.delegate = self
    }
}

extension ProfileViewController {
    
    func configureCollectionViewDataSource() {
        
        let headercellRegistration = UICollectionView.CellRegistration<HeaderCell,Header> { cell, indexPath, itemIdentifier in
            cell.cardStackView.button1.setTitleColor(.black, for: .normal)
        }
        
        let subCellRegistration = UICollectionView.CellRegistration<SubCell,Sub> { cell, indexPath, itemIdentifier in
            cell.backgroundColor = .white
        }
        
        collectionViewDataSource = UICollectionViewDiffableDataSource<Int, Item>(collectionView: selfView.collectionView) {
            collectionView, indexPath, itemIdentifier in
            switch itemIdentifier {
            case .header(let header):
                let cell = self.selfView.collectionView.dequeueConfiguredReusableCell(using: headercellRegistration, for: indexPath, item: header)
                return cell
            case .sub(let sub):
                let cell = self.selfView.collectionView.dequeueConfiguredReusableCell(using: subCellRegistration, for: indexPath, item: sub)
                return cell
            }
        }
        
        let headerRegistration = UICollectionView.SupplementaryRegistration<MyInfoHeaderView>(elementKind: UICollectionView.elementKindSectionHeader) { supplementaryView, elementKind, indexPath in
        }
        
        collectionViewDataSource.supplementaryViewProvider =  { collectionView, elementKind, indexPath in
            let suppleymentaryView  = collectionView.dequeueConfiguredReusableSupplementary(using: headerRegistration, for: indexPath)
            return suppleymentaryView
        }
    }
    
    
    
    func applySnapshot() {
        var snapshot = self.collectionViewDataSource.snapshot()
        snapshot.appendSections([0, 1])
        snapshot.appendItems(headerData.map(Item.header))
        snapshot.appendItems(subData.map(Item.sub))
        collectionViewDataSource.apply(snapshot)
    }
    
    
}






extension ProfileViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        shouldSelectItemAt indexPath: IndexPath) -> Bool {
        guard let dataSource = collectionViewDataSource else { return false }
        
        
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

    func refresh(completion: (() -> Void)? = nil) {
        self.apply(self.snapshot(), animatingDifferences: true, completion: completion)
    }
}
