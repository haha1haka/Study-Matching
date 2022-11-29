import UIKit

class CardCollectionDataSource: UICollectionViewDiffableDataSource<Section, Card>, DataSourceRegistration {

    convenience init(collectionView:       UICollectionView,
                     headerRegistration:   CardHeaderRegistration,
                     mainCellRegistration: CardCellRegistration)
                     
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
    

//    func applySnapshot() {
//        let section1 = Section(label: "1")
//        let section2 = Section(label: "2")
//        var snapshot = snapshot()
//        snapshot.appendSections([section1, section2])
//        snapshot.appendItems([Card()], toSection: section1)
//        snapshot.appendItems([Card()], toSection: section2)
//        apply(snapshot)
//    }

    func refresh() {
        apply(snapshot(), animatingDifferences: true)
    }
}
struct Section: Hashable {
    let uuid = UUID()
    let label: String
}

struct Card: Hashable {
    let uuid = UUID()
    var nick: String
    var reputation: [Int]
    var studyList: [String]
    var reviews: [String]
    var gender: Int
    var type: Int
    var sesac: Int
    var background: Int
}
