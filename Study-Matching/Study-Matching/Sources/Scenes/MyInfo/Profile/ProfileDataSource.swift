import UIKit
import RxSwift
import RxCocoa


class ProfileDataSource: UICollectionViewDiffableDataSource<Int, Item> {

    convenience init(collectionView: UICollectionView,_ mainCellRegistration: UICollectionView.CellRegistration<ProfileMainCell, MemoleaseUser>,_ subCellRegistration: UICollectionView.CellRegistration<ProfileSubCell, MemoleaseUser>) {
        
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

        let headerRegistration = UICollectionView.SupplementaryRegistration<ProfileHeaderView>(
            elementKind: UICollectionView.elementKindSectionHeader)
        { supplementaryView, elementKind, indexPath in}

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


enum Item: Hashable {
    case main(MemoleaseUser)
    case sub(MemoleaseUser)
}
struct Main: Hashable {
    var title: String
}

struct Sub: Hashable {
    var title: String
}
