import UIKit



class ProfileDataSource: UICollectionViewDiffableDataSource<Int, Item> {
    
    convenience init(collectionView: UICollectionView) {

        let headercellRegistration = UICollectionView.CellRegistration<HeaderCell,Header> { cell, indexPath, itemIdentifier in
            cell.cardStackView.button1.setTitleColor(.black, for: .normal)
        }
        
        let subCellRegistration = UICollectionView.CellRegistration<SubCell,Sub> { cell, indexPath, itemIdentifier in
            cell.backgroundColor = .white
        }
        
        self.init(collectionView: collectionView) {
            collectionView, indexPath, itemIdentifier in
            switch itemIdentifier {
            case .header(let header):
                let cell = collectionView.dequeueConfiguredReusableCell(using: headercellRegistration, for: indexPath, item: header)
                return cell
            case .sub(let sub):
                let cell = collectionView.dequeueConfiguredReusableCell(using: subCellRegistration, for: indexPath, item: sub)
                return cell
            }
        }
        
        let headerRegistration = UICollectionView.SupplementaryRegistration<ProfileHeaderView>(elementKind: UICollectionView.elementKindSectionHeader) { supplementaryView, elementKind, indexPath in
        }
        
        supplementaryViewProvider =  { collectionView, elementKind, indexPath in
            let suppleymentaryView  = collectionView.dequeueConfiguredReusableSupplementary(using: headerRegistration, for: indexPath)
            return suppleymentaryView
        }
    }
    
    func applyInitialSnapshot() {
        var snapshot = snapshot()
        snapshot.appendSections([0, 1])
        snapshot.appendItems(Item.headerData.map(Item.header))
        snapshot.appendItems(Item.subData.map(Item.sub))
        apply(snapshot)
    }
    
    func refresh() {
        apply(snapshot(), animatingDifferences: true)
    }
}


enum Item: Hashable {
    case header(Header)
    case sub(Sub)
    
    static let headerData = [Header(title: "안녕")]
    static let subData = [Sub(title: "hi")]
}
struct Header: Hashable {
    var title: String
}

struct Sub: Hashable {
    var title: String
}
