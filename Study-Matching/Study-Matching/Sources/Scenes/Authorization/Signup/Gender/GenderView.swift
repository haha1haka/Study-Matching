import UIKit
import SnapKit

class GenderView: BaseView {

    let label = SeSacLabel(text_: "성별을 선택해 주세요")
    let subLabel = SeSacLabel(text_: "새싹 찾기 기능을 이용하기 위해서 필요해요!",
                              color: SeSacColor.gray7,
                              font_: SeSacFont.Title2_R16.set)
    
    lazy var collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: configureCollectionViewLayout())
        return view
    }()
    
    let button = SeSacButton(title: "다음")
        
    override func configureHierarchy() {
        [label, subLabel, button].forEach { self.addSubview($0) }
        self.addSubview(collectionView)
        
    }
    
    override func configureLayout() {
        label.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(125)
            $0.leading.trailing.equalTo(self.safeAreaLayoutGuide).inset(74)
            $0.height.equalTo(64)
        }
        
        subLabel.snp.makeConstraints {
            $0.top.equalTo(label.snp.bottom)
            $0.leading.trailing.equalTo(self.safeAreaLayoutGuide).inset(50)
            $0.height.equalTo(26)
        }
        collectionView.snp.makeConstraints {
            $0.top.equalTo(subLabel.snp.bottom).offset(32)
            $0.leading.trailing.equalTo(self.safeAreaLayoutGuide).inset(16)
            $0.height.equalTo(120)
        }

        button.snp.makeConstraints {
            $0.top.equalTo(collectionView.snp.bottom).offset(32)
            $0.leading.trailing.equalTo(self.safeAreaLayoutGuide).inset(16)
            $0.height.equalTo(48)
            
        }
    }
    
    func configureCollectionViewLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item,count: 2)
        let section = NSCollectionLayoutSection(group: group)
        
        return UICollectionViewCompositionalLayout(section: section)
        
    }

}

