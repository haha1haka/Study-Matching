import UIKit
import SnapKit

class ProfileView: BaseView {
    
    lazy var collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: configureCollectionViewLayout())
        view.alwaysBounceVertical = false
        
        return view
    }()
    
    
    override func configureHierarchy() {
        addSubview(collectionView)
        
    }
    
    override func configureLayout() {
        collectionView.snp.makeConstraints {
            $0.edges.equalTo(self)
        }
        

        
    }
    
    func configureCollectionViewLayout() -> UICollectionViewLayout {
        
        let configuration = UICollectionViewCompositionalLayoutConfiguration()
        
        let collectionViewLayout = UICollectionViewCompositionalLayout(
            sectionProvider:
                { sectionIndex, layoutEnvironment in
                    
                    switch sectionIndex {
                    case 0: return self.headerCellLayout()
                    default: return self.subCellLayout()
                    }
                },
            configuration: configuration)
        
        return collectionViewLayout
    }
    
    
    
    
    
    func headerCellLayout() -> NSCollectionLayoutSection {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(343),
                                             heightDimension: .estimated(400))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
      
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: itemSize,
                                                         subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        //section.interGroupSpacing = 12
        //section.contentInsets = .init(top: 0, leading: 12, bottom: 12, trailing: 12)
        
        
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .absolute(373),
                                                heightDimension: .absolute(194))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        section.boundarySupplementaryItems = [header]
        
        
        return section
    }
    
    
    
    
    
    func subCellLayout() -> NSCollectionLayoutSection {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                             heightDimension: .estimated(400))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
      
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: itemSize,
                                                         subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 12
        section.contentInsets = .init(top: 12, leading: 12, bottom: 12, trailing: 12)
        
        return section
    }
    


}


