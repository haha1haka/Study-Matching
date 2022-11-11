import UIKit
import RxSwift
import RxCocoa

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


class OnBoardingViewController: BaseViewController {
    


    let selfView = OnBoardingView()
    override func loadView() {
        view = selfView
    }
    
    let viewModel = OnboardingViewModel()
    let disposeBag = DisposeBag()
    
    var collectionViewDataSource: UICollectionViewDiffableDataSource<Section, Page>!
    
}

extension OnBoardingViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        selfView.eventDelegate = self
        configureCollectionViewDataSource()
        applySnapshot()
    }
}

extension OnBoardingViewController {
    func configureCollectionViewDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<OnboardCell, Page> { cell, indexPath, itemIdentifier in
            cell.configureAttributes(item: itemIdentifier)
            print("fdasfdasfdasfdsfdsfasdfsadfas")
        }
        
        collectionViewDataSource = UICollectionViewDiffableDataSource<Section, Page>(collectionView: selfView.collectionView) { collectionView, indexPath, itemIdentifier in
            let cell = self.selfView.collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
            return cell
        }
//
        let footerRegistration = UICollectionView.SupplementaryRegistration<FooterView>(elementKind: UICollectionView.elementKindSectionFooter) { supplementaryView, elementKind, indexPath in
            let itemCount = self.collectionViewDataSource.snapshot().numberOfItems

            supplementaryView.configure(with: itemCount)
            
            print("fdsfadsfasdfa")
            self.viewModel.pageIndex.bind(onNext: { int in
                supplementaryView.pageControl.currentPage = int
            })
            .disposed(by: self.disposeBag)
        }

        collectionViewDataSource.supplementaryViewProvider = { collectionView, elementKind, indexPath in
            let suppleymentaryView  = self.selfView.collectionView.dequeueConfiguredReusableSupplementary(using: footerRegistration, for: indexPath)
            return suppleymentaryView
        }
    }
    
    
    func applySnapshot() {
        let items = Page.setData
        var snapshot = NSDiffableDataSourceSnapshot<Section, Page>()
        snapshot.appendSections([.main])
        snapshot.appendItems(items)
        collectionViewDataSource.apply(snapshot)
    }
}




extension OnBoardingViewController: OnBoardingViewEvent {
    func page(_ view: OnBoardingView, pageIndex: Int) {
        viewModel.pageIndex.onNext(pageIndex)
    }
}
