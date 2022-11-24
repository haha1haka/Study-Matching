import UIKit
import RxSwift
import RxCocoa

class SearchViewController: BaseViewController, DataSourceRegistration {
    
    let selfView  = SearchView()
    let viewModel  = SearchViewModel()
    let disposeBag = DisposeBag()
    
    var header    : SearchHeaderRegistration?
    var topCell   : SearchTopCellRegistration?
    var bottomCell: SearchBottomCellRegistration?
    var wantedStudyList: [Wanted] = []
    
    lazy var dataSource = SearchDataSource(
        collectionView: selfView.collectionView,
        headerRegistration: self.header!,
        topCellRegistration: self.topCell!,
        bottomCellRegistration: self.bottomCell!)
    
    override func loadView() { view = selfView }
    
    override func setNavigationBar(title: String = "") {
        super.setNavigationBar(title: title)
        //let back = UIBarButtonItem(image: SeSacImage.arrow, style: .plain, target: self, action: nil)
        //self.navigationItem.leftBarButtonItem = back
        let searchBar = UISearchBar()
        searchBar.placeholder = "띄어쓰기로 복수 입력이 가능해요"
        self.navigationItem.titleView = searchBar
    }
    
    
}

extension SearchViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        selfView.collectionView.delegate = self
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        requestQueueSearch()
    }
}

extension SearchViewController {
    func bind() {
        
        header = SearchHeaderRegistration (elementKind: UICollectionView.elementKindSectionHeader)
        { supplementaryView, elementKind, indexPath in
            guard let sectionIdentifier = self.dataSource.sectionIdentifier(for: indexPath.section) else { return }
            
            switch sectionIdentifier {
            case .zero:
                supplementaryView.sectionLabel.text = "지금 주변에는"
            default:
                supplementaryView.sectionLabel.text = "내가 하고 싶은"
            }
        }
        
        topCell = SearchTopCellRegistration
        { cell, indexPath, itemIdentifier in
            cell.configure(with: itemIdentifier)
        }
        
        
        bottomCell = SearchBottomCellRegistration
        { cell, indexPath, itemIdentifier in
            cell.configure(with: itemIdentifier)
            
        }
        
        viewModel.nearbyStudyList
            .bind(onNext: {
                var snapshot = self.dataSource.snapshot()
                snapshot.deleteAllItems()
                snapshot.appendSections([0])
                snapshot.appendItems($0.map(SearchStudy.nearby), toSection: 0)
                self.dataSource.apply(snapshot)
            })
            .disposed(by: disposeBag)
        
        
        
        viewModel.wantedStudyList
            .bind(onNext: {
                var snapshot = self.dataSource.snapshot()
                snapshot.deleteSections([1])
                snapshot.appendSections([1])
                snapshot.appendItems($0.map(SearchStudy.wanted), toSection: 1)
                self.dataSource.apply(snapshot)
            })
            .disposed(by: disposeBag)
        
    }
}



extension SearchViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let sectionItem = dataSource.itemIdentifier(for: indexPath)
        switch sectionItem {
        case .nearby(let nearby):
            let wantedStudy = Wanted(label: nearby.label)
            self.wantedStudyList.append(wantedStudy)
            self.viewModel.wantedStudyList.accept(self.wantedStudyList)
        case .wanted(let wanted):
            return
        default:
            return
        }
    }
}

extension SearchViewController {
    func requestQueueSearch() {
        self.viewModel.requestQueueSearch {
            switch $0 {
            case .success:
                return
            case .failure(let error):
                switch error {
                case .idTokenError:
                    self.requestQueueSearch()
                    return
                case .unRegistedUser:
                    print("⚠️미가입된 회원입니다")
                default:
                    return
                }
            }
        }
    }
}
