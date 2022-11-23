import UIKit

class ProfileDataSource: UICollectionViewDiffableDataSource<Int, Item>, DataSourceRegistration {

    convenience init(collectionView:       UICollectionView,
                     headerRegistration:   ProfileHeaderRegistration,
                     mainCellRegistration: ProfileMainCellRegistration,
                     subCellRegistration:  ProfileSubCellRegistration)
    {
        self.init(collectionView: collectionView) {
            collectionView, indexPath, itemIdentifier in
            switch itemIdentifier {
            case .main(let main):
                let cell = collectionView.dequeueConfiguredReusableCell(
                    using: mainCellRegistration,
                    for: indexPath,
                    item: main)
                return cell
            case .sub(let sub):
                let cell = collectionView.dequeueConfiguredReusableCell(
                    using: subCellRegistration,
                    for: indexPath,
                    item: sub)
                return cell
            }
        }

        supplementaryViewProvider =  { collectionView, elementKind, indexPath in
            let suppleymentaryView  = collectionView.dequeueConfiguredReusableSupplementary(
                using: headerRegistration,
                for: indexPath)
            return suppleymentaryView }
    }

    func applySnapshot() {
        var snapshot = snapshot()
        snapshot.appendSections([0, 1])
        snapshot.appendItems([Item.main(Main())])
        snapshot.appendItems([Item.sub(Sub())])
        apply(snapshot)
    }

    func refresh() {
        apply(snapshot(), animatingDifferences: true)
    }
}


enum Item: Hashable {
    case main(Main)
    case sub(Sub)
}
struct Main: Hashable {
    
}

struct Sub: Hashable {
    
}
