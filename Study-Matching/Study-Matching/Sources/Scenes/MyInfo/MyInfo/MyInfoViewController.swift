import UIKit

class MyInfoViewController: BaseViewController {
    let selfView = MyInfoView()
    override func loadView() {
        view = selfView
    }
    var collectionViewDataSource: UICollectionViewDiffableDataSource<Section, Setting>!
    
    enum Section {
        case main
    }
    struct Setting: Hashable {
        let image: UIImage
        let label: String
        static let data = [Setting(image: SeSacImage.notice!, label: "공지사항"),
                           Setting(image: SeSacImage.faq!, label: "자주 묻는 질문"),
                           Setting(image: SeSacImage.qna!, label: "1:1 문의"),
                           Setting(image: SeSacImage.settingAlarm!, label: "알림 설정"),
                           Setting(image: SeSacImage.permit!, label: "이용 약관"),]

    }
}

extension MyInfoViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionViewDataSource()
        applySnapshot()
    }
}

extension MyInfoViewController {
    func configureCollectionViewDataSource() {



        let cellRegistration = UICollectionView.CellRegistration<MyInfoCell,Setting> { cell, indexPath, itemIdentifier in
            cell.imageView.image = itemIdentifier.image
            cell.label.text = itemIdentifier.label
        }
        
        collectionViewDataSource = UICollectionViewDiffableDataSource<Section, Setting>(collectionView: selfView.collectionView) {
            collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
            return cell
        }
        
        let headerRegistration = UICollectionView.SupplementaryRegistration<MyInfoHeaderView>(elementKind: UICollectionView.elementKindSectionHeader) { supplementaryView, elementKind, indexPath in
        }

        collectionViewDataSource.supplementaryViewProvider =  { collectionView, elementKind, indexPath in
            let suppleymentaryView  = self.selfView.collectionView.dequeueConfiguredReusableSupplementary(using: headerRegistration, for: indexPath)
            return suppleymentaryView
        }









    }

    func applySnapshot() {
        var snapshot = collectionViewDataSource.snapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(Setting.data)
        collectionViewDataSource.apply(snapshot)
    }
}

extension MyInfoViewController {

}



