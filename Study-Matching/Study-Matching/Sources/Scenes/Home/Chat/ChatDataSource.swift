import UIKit

class ChatDataSource: UICollectionViewDiffableDataSource<Int, Chat>, DataSourceRegistration {

    convenience init(collectionView:       UICollectionView,
                     headerRegistration:   ChatHeaderRegistration,
                     chatLeftRegistration: ChatLeftCellRegistration,
                     chatRightRegitstrion:  ChatRightCellRegistration)
    {
        self.init(collectionView: collectionView) {
            collectionView, indexPath, itemIdentifier in
            switch itemIdentifier {
            case .left(let left):
                let cell = collectionView.dequeueConfiguredReusableCell(
                    using: chatLeftRegistration,
                    for: indexPath,
                    item: left)
                return cell
            case .right(let right):
                let cell = collectionView.dequeueConfiguredReusableCell(
                    using: chatRightRegitstrion,
                    for: indexPath,
                    item: right)
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


enum Chat: Hashable {
    case left(Left)
    case right(Right)
}
struct Left: Hashable {
    var uuid = UUID()
    var text: String
}

struct Right: Hashable {
    var uuid = UUID()
    var text: String
}
