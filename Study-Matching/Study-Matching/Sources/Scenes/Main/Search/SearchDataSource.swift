import UIKit

class SearchDataSource: UICollectionViewDiffableDataSource<Int, SearchStudy>, DataSourceRegistration {

    convenience init(collectionView        : UICollectionView,
                     headerRegistration    : SearchHeaderRegistration,
                     topCellRegistration   : SearchTopCellRegistration,
                     bottomCellRegistration: SearchBottomCellRegistration)
    {
        self.init(collectionView: collectionView) {
            collectionView, indexPath, itemIdentifier in
            switch itemIdentifier {
            case .nearby(let nearby):
                let cell = collectionView.dequeueConfiguredReusableCell(
                    using: topCellRegistration,
                    for: indexPath,
                    item: nearby)
                return cell
            case .wish(let wish):
                let cell = collectionView.dequeueConfiguredReusableCell(
                    using: bottomCellRegistration,
                    for: indexPath,
                    item: wish)
                return cell
            }
        }

        supplementaryViewProvider =  { collectionView, elementKind, indexPath in
            let suppleymentaryView  = collectionView.dequeueConfiguredReusableSupplementary(
                using: headerRegistration,
                for: indexPath)
            return suppleymentaryView }
    }


}


enum SearchStudy: Hashable {
    case nearby(Nearby)
    case wish(Wish?)
}

struct Nearby: Hashable {
    let label: String
    let titleColor: UIColor
    let borderColor: UIColor
    
    init(label: String, titleColor: UIColor = SeSacColor.black , borderColor: UIColor = SeSacColor.gray4) {
        self.label = label
        self.titleColor = titleColor
        self.borderColor = borderColor
    }
}

struct Wish: Hashable {
    let label: String
    
}
