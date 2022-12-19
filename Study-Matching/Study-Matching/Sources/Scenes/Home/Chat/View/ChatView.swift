import UIKit
import SnapKit

class ChatView: BaseView {
    
    lazy var collectionView: UICollectionView = {
        let view = UICollectionView(
            frame: .zero,
            collectionViewLayout: configureCollectionViewLayout())
        view.alwaysBounceVertical = false
        view.showsVerticalScrollIndicator = false
        return view
    }()
    
    lazy var stackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [
            textView, sendButton
        ])
        view.backgroundColor = SeSacColor.gray1
        view.axis = .horizontal
        view.toRadius
        return view
    }()
    
    let textView: UITextView = {
        let view = UITextView()
        view.backgroundColor = .clear
        view.font = SeSacFont.Body3_R14.set
        view.tintColor = SeSacColor.black
        return view
    }()
    
    let sendButton: UIButton = {
        let view = UIButton()
        view.setImage(SeSacImage.sendAct, for: .normal)
        return view
    }()
    
    override func configureHierarchy() {
        addSubview(collectionView)
        addSubview(stackView)
    }
    
    override func configureLayout() {
        collectionView.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide)
            $0.leading.trailing.equalTo(self)
            $0.bottom.equalTo(stackView.snp.top)
        }
        
        stackView.snp.makeConstraints {
            $0.leading.trailing.equalTo(self.safeAreaLayoutGuide).inset(16)
            $0.bottom.equalTo(keyboardLayoutGuide.snp.top)
            $0.height.greaterThanOrEqualTo(52)
        }
                
    }
    
    func configureCollectionViewLayout() -> UICollectionViewLayout {
        
        let configuration = UICollectionViewCompositionalLayoutConfiguration()
        
        let collectionViewLayout = UICollectionViewCompositionalLayout(
            sectionProvider:
                { sectionIndex, layoutEnvironment in
                    
                    switch sectionIndex {
                    default:  return self.cellLayout()
                    }
                },
            configuration: configuration)
        
        return collectionViewLayout
    }
    
    func cellLayout() -> NSCollectionLayoutSection {
        
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(32))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(32))
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: [item])
        //group.contentInsets = NSDirectionalEdgeInsets(top: 30, leading: 0, bottom: 30, trailing: 0)
        
        let section = NSCollectionLayoutSection(group: group)

        
        
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.88),
            heightDimension: .fractionalWidth(0.35))
        
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top)
        

        
        section.boundarySupplementaryItems = [header]
        
        
        return section
    }
}


