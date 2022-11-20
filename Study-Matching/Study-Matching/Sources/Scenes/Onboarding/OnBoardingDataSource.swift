import UIKit



class OnBoardingDataSource: UICollectionViewDiffableDataSource<OnBoardingSection, Page>, DataSourceRegistration {
    
    convenience init(collectionView    : UICollectionView,
                     cellRegistration  : OnBoardingCellRegistration,
                     footerRegistration: OnBoardingFooterRegistration)
    {
        
        self.init(collectionView: collectionView) { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(
                using: cellRegistration,
                for:   indexPath,
                item:  itemIdentifier)
            return cell
        }
        
        supplementaryViewProvider = { collectionView, elementKind, indexPath in
            let suppleymentaryView  = collectionView.dequeueConfiguredReusableSupplementary(
                using: footerRegistration,
                for:   indexPath)
            return suppleymentaryView
        }
    }
    
    func applySnapshot() {
        var snapshot = snapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(Page.setData)
        apply(snapshot)
    }
}


enum OnBoardingSection {
    case main
}

struct Page: Hashable {
    var labelImage: UIImage
    var mainImage:  UIImage
    
    static let setData =
    [Page(labelImage: SeSacImage.firstPageImage!, mainImage: SeSacImage.firstPageMainImage!),
    Page(labelImage: SeSacImage.secondPageImage!, mainImage: SeSacImage.secondPageMainImage!),
    Page(labelImage: SeSacImage.thirdPageImage!, mainImage: SeSacImage.thirdPageMainImage!)]
}
