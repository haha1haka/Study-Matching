import UIKit

class ChatDataSource: UICollectionViewDiffableDataSource<Int, Chat>, DataSourceRegistration {

    convenience init(collectionView:       UICollectionView,
                     headerRegistration:   ChatHeaderRegistration,
                     chatLeftRegistration: ChatLeftCellRegistration,
                     chatRightRegitstrion:  ChatRightCellRegistration)
    {
        self.init(collectionView: collectionView) {
            collectionView, indexPath, itemIdentifier in
            print("🥶🥶🥶\(itemIdentifier.from).,.,.,\(UserDefaultsManager.standard.myUid)")
            if itemIdentifier.from != UserDefaultsManager.standard.myUid {
                let cell = collectionView.dequeueConfiguredReusableCell(
                    using: chatLeftRegistration,
                    for: indexPath,
                    item: itemIdentifier)
                return cell
            } else {
                let cell = collectionView.dequeueConfiguredReusableCell(
                    using: chatRightRegitstrion,
                    for: indexPath,
                    item: itemIdentifier)
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


//enum ChatItem: Hashable {
//    case left(Left)
//    case right(Right)
//}
//struct Left: Hashable {
//    var uuid = UUID()
//    var text: String
//    var createdAt: String
//}
//
//struct Right: Hashable {
//    var uuid = UUID()
//    var text: String
//    var createdAt: String
//}
