import UIKit


protocol OnBoardingDataSourceDelegate: AnyObject {
    func supplementaryView(_ dataSource: OnBoardingDataSource, supplementaryView: OnBoardingFooterView)
}

class OnBoardingDataSource: UICollectionViewDiffableDataSource<OnBoardingSection, Page> {
    
    var delegate: OnBoardingDataSourceDelegate?
    
    convenience init(collectionView: UICollectionView) {
        
        let cellRegistration = UICollectionView.CellRegistration<OnboardCell, Page> { cell, indexPath, itemIdentifier in
            cell.configure(with: itemIdentifier)
            print("fdasfdasfdasfdsfdsfasdfsadfas")
        }
        
        self.init(collectionView: collectionView) { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
            return cell
        }
        
        
        let footerRegistration = UICollectionView.SupplementaryRegistration<OnBoardingFooterView>(elementKind: UICollectionView.elementKindSectionFooter) { [weak self] supplementaryView, elementKind, indexPath in
            
            guard let self = self else { return }
            
            let itemCount = self.snapshot().numberOfItems
            
            supplementaryView.configure(with: itemCount)
            
            self.delegate?.supplementaryView(self, supplementaryView: supplementaryView)

        }
        
        supplementaryViewProvider = { collectionView, elementKind, indexPath in
            let suppleymentaryView  = collectionView.dequeueConfiguredReusableSupplementary(using: footerRegistration, for: indexPath)
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
    var mainImage: UIImage
    
    static let setData = [Page(labelImage: SeSacImage.firstPageImage!, mainImage: SeSacImage.firstPageMainImage!),
                          Page(labelImage: SeSacImage.secondPageImage!, mainImage: SeSacImage.secondPageMainImage!),
                          Page(labelImage: SeSacImage.thirdPageImage!, mainImage: SeSacImage.thirdPageMainImage!)]
}
