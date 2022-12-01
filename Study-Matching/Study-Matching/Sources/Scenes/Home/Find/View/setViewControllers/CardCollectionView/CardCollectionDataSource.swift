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
    
    func refresh() {
        apply(snapshot(), animatingDifferences: true)
    }
}
struct Section: Hashable {
    let uuid = UUID()
    var label: String
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
    var uid: Int
}
