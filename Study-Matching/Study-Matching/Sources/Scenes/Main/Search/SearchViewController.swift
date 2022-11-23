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
        dataSource.applySnapshot()
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
            
        }
    }
}

extension SearchViewController {
    
}
