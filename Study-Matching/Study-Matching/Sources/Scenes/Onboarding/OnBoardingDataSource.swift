import UIKit

enum Section {
    case main
}

struct Page: Hashable {
    var labelImage: UIImage
    var mainImage: UIImage
    
    static let setData = [Page(labelImage: SeSacImage.firstPageImage!, mainImage: SeSacImage.firstPageMainImage!),
                          Page(labelImage: SeSacImage.secondPageImage!, mainImage: SeSacImage.secondPageMainImage!),
                          Page(labelImage: SeSacImage.thirdPageImage!, mainImage: SeSacImage.thirdPageMainImage!)]
}


class OnBoardingDataSource: UICollectionViewDiffableDataSource<Section, Page> {
    
    convenience init(collectionView: UICollectionView) {
        
        let cellRegistration = UICollectionView.CellRegistration<OnboardCell, Page> { cell, indexPath, itemIdentifier in
            cell.configureAttributes(item: itemIdentifier)
            print("fdasfdasfdasfdsfdsfasdfsadfas")
        }
        
        self.init(collectionView: collectionView) { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
            return cell
        }
        
        
        let footerRegistration = UICollectionView.SupplementaryRegistration<FooterView>(elementKind: UICollectionView.elementKindSectionFooter) { supplementaryView, elementKind, indexPath in
            let itemCount = self.snapshot().numberOfItems
            
            supplementaryView.configure(with: itemCount)
            
            //            print("fdsfadsfasdfa")
            //            self.viewModel.pageIndex.bind(onNext: { int in
            //                supplementaryView.pageControl.currentPage = int
            //            })
            //            .disposed(by: self.disposeBag)
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
