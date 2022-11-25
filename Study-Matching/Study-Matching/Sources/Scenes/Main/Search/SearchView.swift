import UIKit
import SnapKit

class SearchView: BaseView {

    var searchButtonConstraint: NSLayoutConstraint?
    
    lazy var collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: configureCollectionViewLayout())
        view.alwaysBounceVertical = false
        return view
    }()
    
    let searchButton: SeSacButton = {
        let view = SeSacButton(title: "새싹찾기", color: SeSacColor.green)
        return view
    }()

    
    override func configureHierarchy() {
        addSubview(collectionView)
        addSubview(searchButton)
    }
    
    override func configureLayout() {

        collectionView.snp.makeConstraints {
            $0.edges.equalTo(self.safeAreaLayoutGuide)
        }


        searchButton.snp.updateConstraints {
            $0.leading.trailing.equalTo(self.safeAreaLayoutGuide)
            $0.height.equalTo(48)
            //$0.bottom.equalTo(self.keyboardLayoutGuide).offset(16)
            
            
        }
        
    }

    func configureCollectionViewLayout() -> UICollectionViewLayout {
        
        let configuration = UICollectionViewCompositionalLayoutConfiguration()
        configuration.interSectionSpacing = 8        
        let collectionViewLayout = UICollectionViewCompositionalLayout(
            sectionProvider:
                { sectionIndex, layoutEnvironment in
                    
                    switch sectionIndex {
                    default: return self.cellLayout()
                    }
                },
            
            configuration: configuration)
        
        
        return collectionViewLayout
    }
    
    
    
    func cellLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .estimated(128),
            heightDimension: .estimated(128))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.edgeSpacing = .init(leading: .fixed(4), top: .fixed(4), trailing: .fixed(4), bottom: .fixed(4))
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(128))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        
        section.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 16, bottom: 24, trailing: 16)
        section.interGroupSpacing = 8
        
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(64))
        
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top)
        
        section.boundarySupplementaryItems = [header]
        return section
    }

    
}

