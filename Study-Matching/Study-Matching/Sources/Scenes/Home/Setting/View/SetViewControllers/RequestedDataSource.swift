import UIKit

class RequestedDataSource: UICollectionViewDiffableDataSource<Int, Main>, DataSourceRegistration {

    convenience init(collectionView:       UICollectionView,
                     headerRegistration:   RequestedHeadRegistration,
                     mainCellRegistration: RequestedCellRegistration)
                     
    {
        self.init(collectionView: collectionView) {
            collectionView, indexPath, itemIdentifier in

                let cell = collectionView.dequeueConfiguredReusableCell(
                    using: mainCellRegistration,
                    for: indexPath,
                    item: itemIdentifier)
                return cell
            
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
        snapshot.appendItems([Main()], toSection: 0)
        snapshot.appendItems([Main()], toSection: 1)
        apply(snapshot)
    }

    func refresh() {
        apply(snapshot(), animatingDifferences: true)
    }
}


