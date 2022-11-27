import UIKit

class RequestedDataSource: UICollectionViewDiffableDataSource<Section, Main>, DataSourceRegistration {

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
        let section1 = Section(label: "1")
        let section2 = Section(label: "2")
        var snapshot = snapshot()
        snapshot.appendSections([section1, section2])
        snapshot.appendItems([Main()], toSection: section1)
        snapshot.appendItems([Main()], toSection: section2)
        apply(snapshot)
    }

    func refresh() {
        apply(snapshot(), animatingDifferences: true)
    }
}


