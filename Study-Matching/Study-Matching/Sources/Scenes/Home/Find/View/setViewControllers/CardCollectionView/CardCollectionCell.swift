import UIKit
import SnapKit
struct Study: Hashable {
    let uuid = UUID()
    let label: String
}

class CardCollectionCell: BaseCollectionViewCell {
            
    var closedConstraint: NSLayoutConstraint?
    var openConstraint: NSLayoutConstraint?
    var estimatedItemConstraint: NSLayoutConstraint?
    
    lazy var collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: configureCollectionViewLayout())
        view.alwaysBounceVertical = false
        view.isScrollEnabled = false
        return view
    }()
    
    var dataSource: UICollectionViewDiffableDataSource<Int, Study>!
 
    
    
    
    func configureCollectionViewDataSource() {
        let miniCellRegistration = UICollectionView.CellRegistration<MiniCell, Study> { cell,indexPath,itemIdentifier in
            cell.label.text = itemIdentifier.label
        }
        dataSource = .init(collectionView: self.collectionView) { collectionView, indexPath, itemIdentifier in
            let cell = self.collectionView.dequeueConfiguredReusableCell(using: miniCellRegistration, for: indexPath, item: itemIdentifier)

            return cell
        }
    }

    
    lazy var collectionViewStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [
            collectionView
        ])
        return view
    }()

    lazy var totalStackView: UIStackView = {
        let rootStack = UIStackView(
        arrangedSubviews: [
            topStackView,
            middleStackView,
            collectionViewStackView,
            bottomStackView
        ])
        rootStack.alignment = .top
        rootStack.distribution = .fillProportionally
        rootStack.axis = .vertical
        rootStack.spacing = 24
        return rootStack
    }()
    
    
    lazy var topStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [nameLabel, disclosureView])
        //view.distribution = .fillProportionally
        view.distribution = .fill
        view.axis = .horizontal
        return view
    }()
    
    lazy var middleStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [
            sectionLabel1,
            cardStackView
        ])
        view.axis = .vertical
        view.spacing = 16
        return view
    }()
    
    lazy var bottomStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [
            label,
            reviewLabel
        ])
        view.axis = .vertical
        view.spacing = 16
        
        return view
    }()

    
    var nameLabel: UILabel = {
        let view = UILabel()
        view.text = "김새싹"
        view.font = SeSacFont.Title1_M16.set
        return view
    }()
    
    let disclosureView: UIImageView = {
        let disclosureView = UIImageView()
        disclosureView.image = UIImage(systemName: "chevron.down")
        disclosureView.contentMode = .scaleAspectFit
        disclosureView.preferredSymbolConfiguration = .init(textStyle: .body, scale: .small)
        disclosureView.tintColor = SeSacColor.gray7
        return disclosureView
    }()
    

    var sectionLabel1: UILabel = {
        let view = UILabel()
        view.text = "새싹 타이틀"
        view.font = SeSacFont.Title6_R12.set

        return view
    }()
    
    lazy var cardStackView: CardStackView = {
        let view = CardStackView()
        return view
    }()
    

    lazy var label: UILabel = {
        let view = UILabel()
        view.text = "새싹리뷰"
        view.textAlignment = .left
        view.font = SeSacFont.Title6_R12.set
        view.backgroundColor = SeSacColor.white
        view.textColor = SeSacColor.black
        view.addSubview(reviewButton)
        return view
    }()
    var reviewButton: UIButton = {
        let view = UIButton()
        
        view.backgroundColor = .clear
        return view
    }()
    
    let reviewLabel: UILabel = {
        let view = UILabel()
        view.backgroundColor = .white
        view.font = SeSacFont.Body3_R14.set
        view.textColor = SeSacColor.black
        view.text = "첫 리뷰를 기다리는 중이에요!"
        return view
    }()
    
    

    override var isSelected: Bool {
        didSet {
            updateAppearance()
        }
    }
    

    override func configureHierarchy() {
        contentView.addSubview(totalStackView)
        configureCollectionViewDataSource()
    }
    
    override func configureLayout() {
        contentView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
        totalStackView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.leading.trailing.equalTo(self).inset(16)
        }
        
        topStackView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
        }

        
        middleStackView.snp.makeConstraints( {
            $0.top.equalTo(topStackView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
        })
        
        collectionViewStackView.snp.makeConstraints {
            $0.top.equalTo(middleStackView.snp.bottom).offset(16)
            $0.leading.trailing.equalTo(contentView)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.equalTo(50)
                
            
        }
        
        bottomStackView.snp.makeConstraints {
            $0.top.equalTo(collectionViewStackView.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview()
        }
        
        nameLabel.snp.makeConstraints {
            $0.height.equalTo(58)
            $0.trailing.equalTo(disclosureView.snp.leading)
        }
        
        disclosureView.snp.makeConstraints {
            $0.trailing.equalToSuperview()
            $0.width.equalTo(12)
            
            
            
        }

        closedConstraint =
        nameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0)
        closedConstraint?.priority = .defaultLow
        
        openConstraint =
        reviewLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        openConstraint?.priority = .defaultLow
        
        updateAppearance()
        

        
    }
    
    
    override func configureAttributesInit() {

    }
    
    func configureCollectionViewLayout() -> UICollectionViewLayout {
        
        let configuration = UICollectionViewCompositionalLayoutConfiguration()
        
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
            widthDimension: .estimated(32),
            heightDimension: .estimated(32))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.edgeSpacing = .init(leading: .fixed(4), top: .fixed(4), trailing: .fixed(4), bottom: .fixed(4))
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(32))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        
        section.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 16, bottom: 24, trailing: 16)
        section.interGroupSpacing = 8
        
//        let headerSize = NSCollectionLayoutSize(
//            widthDimension: .fractionalWidth(1.0),
//            heightDimension: .estimated(64))
//
//        let header = NSCollectionLayoutBoundarySupplementaryItem(
//            layoutSize: headerSize,
//            elementKind: UICollectionView.elementKindSectionHeader,
//            alignment: .top)
        
        //section.boundarySupplementaryItems = [header]
        return section
    }
    
    func configureCell(with item: Card) {
        nameLabel.text = item.nick
        
        
        
        for i in cardStackView.buttons {
            if item.reputation[i.tag] != 0 {
                i.toAct
            }
        }
        
        var snapshot = self.dataSource.snapshot()
        snapshot.deleteAllItems()
        snapshot.appendSections([0])
        snapshot.appendItems(item.studyList.map{Study(label: $0)})
        self.dataSource.apply(snapshot)
        
        layer.borderWidth = 1
        layer.borderColor = SeSacColor.gray2.cgColor
        layer.masksToBounds = true
        layer.cornerRadius = 8
        
        
    }


    
    
    

}


extension CardCollectionCell {
    func updateAppearance() {
        print("fasdfasdfas")
        closedConstraint?.isActive = !isSelected
        openConstraint?.isActive = isSelected
        
        UIView.animate(withDuration: 0.3) {
            let upsideDown = CGAffineTransform(rotationAngle: .pi * 0.999 )
            self.disclosureView.transform = self.isSelected ? upsideDown :.identity
        }
    }
}
