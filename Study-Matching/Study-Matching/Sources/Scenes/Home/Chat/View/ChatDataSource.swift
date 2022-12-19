import UIKit

class ChatDataSource: UICollectionViewDiffableDataSource<Int, Chat>, DataSourceRegistration {

    convenience init(collectionView:       UICollectionView,
                     headerRegistration1:   ChatHeaderRegistration1,
                     headerRegistration2:   ChatHeaderRegistration2,
                     chatLeftRegistration: ChatLeftCellRegistration,
                     chatRightRegitstrion:  ChatRightCellRegistration)
    {
        self.init(collectionView: collectionView) {
            collectionView, indexPath, itemIdentifier in
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
            
            switch indexPath.section {
            case 0:
                let suppleymentaryView  = collectionView.dequeueConfiguredReusableSupplementary(
                    using: headerRegistration1,
                    for: indexPath)
                return suppleymentaryView
            default:
                let suppleymentaryView  = collectionView.dequeueConfiguredReusableSupplementary(
                    using: headerRegistration2,
                    for: indexPath)
                return suppleymentaryView
            }
        }
    }
}

