import UIKit
import RxSwift
import RxCocoa


protocol ProfileDataSourceDelegate: AnyObject {
    func mainCell(maincell: ProfileMainCell)
    func subCell(subcell: ProfileSubCell)
}



class ProfileDataSource: UICollectionViewDiffableDataSource<Int, Item> {


    var delegate: ProfileDataSourceDelegate?

    convenience init(collectionView: UICollectionView,_ mainCellRegistration: UICollectionView.CellRegistration<ProfileMainCell, Main>,_ subCellRegistration: UICollectionView.CellRegistration<ProfileSubCell, Sub>) {



        self.init(collectionView: collectionView) {

            collectionView, indexPath, itemIdentifier in
            switch itemIdentifier {
            case .main(let main):
                let cell = collectionView.dequeueConfiguredReusableCell(using: mainCellRegistration, for: indexPath, item: main)
                print(indexPath)

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
        snapshot.appendItems(Item.mainData.map(Item.main))
        snapshot.appendItems(Item.subData.map(Item.sub))
        apply(snapshot)
    }

    func refresh() {
        apply(snapshot(), animatingDifferences: true)
    }
}


enum Item: Hashable {
    case main(Main)
    case sub(Sub)
    
    static let mainData = [Main(title: "안녕")]
    static let subData = [Sub(title: "hi")]
}
struct Main: Hashable {
    var title: String
}

struct Sub: Hashable {
    var title: String
}
