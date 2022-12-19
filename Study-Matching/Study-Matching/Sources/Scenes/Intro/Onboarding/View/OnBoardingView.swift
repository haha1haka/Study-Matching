import UIKit
import SnapKit

protocol OnBoardingViewEvent: AnyObject {
    func page(_ view: OnBoardingView, pageIndex: Int)
}

class OnBoardingView: BaseView {
    
    lazy var collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: configureCollectionViewLayout())
        view.alwaysBounceVertical = false
        return view
    }()
    
    let button = SeSacButton(title: "시작하기")
    
    var eventDelegate: OnBoardingViewEvent?
    
    override func configureHierarchy() {
        addSubview(collectionView)
        addSubview(button)
    }
    
    override func configureLayout() {
        collectionView.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(72)
            $0.leading.trailing.equalTo(self)
            $0.height.equalTo(410) // 360 + FooterReusableView
        }
        
        button.snp.makeConstraints {
            $0.top.equalTo(collectionView.snp.bottom).offset(45)
            $0.leading.trailing.equalTo(self.safeAreaLayoutGuide).inset(16)
            $0.height.equalTo(48)
        }
        
    }
    
    func configureCollectionViewLayout() -> UICollectionViewLayout {
        let itemLayoutSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0))
        
        let itemLayout = NSCollectionLayoutItem(layoutSize: itemLayoutSize)
        
        let groupLayoutSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalWidth(0.98))
        
        let groupLayout = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupLayoutSize,
            subitems: [itemLayout])
        
        let sectionLayout = NSCollectionLayoutSection(group: groupLayout)
        sectionLayout.orthogonalScrollingBehavior = .paging
        sectionLayout.visibleItemsInvalidationHandler = { [weak self] visibleItems, contentOffset, environment in
            guard let self = self else { return }
            self.eventDelegate?.page(self, pageIndex: Int(contentOffset.x / environment.container.contentSize.width))
        }
        let footerItemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(44))
        
        let footerItemLayout = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: footerItemSize,
            elementKind: UICollectionView.elementKindSectionFooter,
            alignment: .bottom)
        
        sectionLayout.boundarySupplementaryItems = [footerItemLayout]
        
        return UICollectionViewCompositionalLayout(section: sectionLayout)
    }
}
