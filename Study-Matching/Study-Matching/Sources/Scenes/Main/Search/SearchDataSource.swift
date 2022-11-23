import UIKit

class SearchDataSource: UICollectionViewDiffableDataSource<Int, SearchItem>, DataSourceRegistration {

    convenience init(collectionView        : UICollectionView,
                     headerRegistration    : SearchHeaderRegistration,
                     topCellRegistration   : SearchTopCellRegistration,
                     bottomCellRegistration: SearchBottomCellRegistration)
    {
        self.init(collectionView: collectionView) {
            collectionView, indexPath, itemIdentifier in
            switch itemIdentifier {
            case .top(let top):
                let cell = collectionView.dequeueConfiguredReusableCell(
                    using: topCellRegistration,
                    for: indexPath,
                    item: top)
                return cell
            case .bottom(let bottom):
                let cell = collectionView.dequeueConfiguredReusableCell(
                    using: bottomCellRegistration,
                    for: indexPath,
                    item: bottom)
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
        snapshot.appendItems(SearchItem.topData.map(SearchItem.top), toSection: 0)
        snapshot.appendItems([SearchItem.bottom(Bottom(label: "안녕"))], toSection: 1)
        apply(snapshot)
    }
}


enum SearchItem: Hashable {
    case top(Top)
    case bottom(Bottom?)
    static let topData = [
            Top(label: "아무거나"),
            Top(label: "SeSAC"),
            Top(label: "코딩"),
            Top(label: "Swift"),
            Top(label: "SwiftUI"),
            Top(label: "CoreData")]
}

struct Top: Hashable {
    let label: String
}

struct Bottom: Hashable {
    let label: String
    
}
