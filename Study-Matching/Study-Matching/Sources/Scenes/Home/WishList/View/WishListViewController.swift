import UIKit
import RxSwift
import RxCocoa



class WishListViewController: BaseViewController, DataSourceRegistration {
    
    let selfView   = WishListView()
    let viewModel  = WishListViewModel()
    let disposeBag = DisposeBag()
    
    var header    : SearchHeaderRegistration?
    var topCell   : SearchTopCellRegistration?
    var bottomCell: SearchBottomCellRegistration?
    
    lazy var dataSource = WishListDataSource(
        collectionView: selfView.collectionView,
        headerRegistration: self.header!,
        topCellRegistration: self.topCell!,
        bottomCellRegistration: self.bottomCell!)
    
    override func loadView() { view = selfView }
    
    override func setNavigationBar(title: String, rightTitle: String) {
        super.setNavigationBar()
        selfView.searchBar.delegate = self
        self.navigationItem.titleView = selfView.searchBar
        self.tabBarController?.tabBar.isHidden = true
    }
    
}

extension WishListViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        selfView.collectionView.delegate = self
        requestQueueSearch()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.wantedStudyDataStore = []
    }
}

extension WishListViewController {
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
        
        selfView.searchBar.rx.searchButtonClicked
            .bind(onNext: {_ in
                self.selfView.searchBar.resignFirstResponder()
                
                
                guard let searchBarText = self.selfView.searchBar.text else { return }
                
                if !self.viewModel.wantedStudyDataStore.contains(searchBarText) {
                    self.viewModel.wantedStudyDataStore.append(searchBarText)
                } else {
                    //self.showToast(message: "이미 존재")
                }
            })
            .disposed(by: disposeBag)
        
        
        selfView.searchButton.rx.tap
            .bind(onNext: { _ in
                self.requestQueue()
            })
            .disposed(by: disposeBag)
    }
}

extension WishListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selfView.searchBar.resignFirstResponder()
        let sectionItem = dataSource.itemIdentifier(for: indexPath)
        switch sectionItem {
        case .nearby(let nearby):
            if !viewModel.wantedStudyDataStore.contains(nearby.label) {
                self.viewModel.wantedStudyDataStore.append(nearby.label)
            } else {
                //self.showToast(message: "이미 존재")
            }
        case .wanted(let wanted):
            if self.viewModel.wantedStudyDataStore.contains(wanted!.label) {
                guard let index = self.viewModel.wantedStudyDataStore.firstIndex(of: wanted!.label) else { return }
                self.viewModel.wantedStudyDataStore.remove(at: index)
            }
            return
        default:
            return
        }
    }
}

extension WishListViewController {
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
    
    func requestQueue() {
        self.viewModel.requestQueue {
            switch $0 {
            case .success:
                let vc = FindViewController()
                vc.pageViewController.nearbyViewController.viewModel.lat.accept(self.viewModel.lat.value)
                vc.pageViewController.nearbyViewController.viewModel.long.accept(self.viewModel.long.value)
                vc.pageViewController.requestedViewController.viewModel.lat.accept(self.viewModel.lat.value)
                vc.pageViewController.requestedViewController.viewModel.long.accept(self.viewModel.long.value)
                self.transition(vc)
            case .failure(let error):
                switch error {
                case .unavailable:
                    return
                case .penalty1:
                    return
                case .penalty2:
                    return
                case .penalty3:
                    return
                case .idTokenError:
                    self.requestQueue()
                case .unRegistedUser:
                    return //다시 로그인 부터 ⚠️
                default:
                    return
                }
            }
        }
    }
}

