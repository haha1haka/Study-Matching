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
    
    var wantedStudyList: [Wanted] = []
    
    override func loadView() { view = selfView }
    
    override func setNavigationBar(title: String, rightTitle: String) {
        super.setNavigationBar()
        selfView.searchBar.delegate = self
        self.navigationItem.titleView = selfView.searchBar
        self.tabBarController?.tabBar.isHidden = true
    }
}

extension SearchViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidHide), name: UIResponder.keyboardDidHideNotification, object: nil)
        
        bind()
        selfView.collectionView.delegate = self
        
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        requestQueueSearch()
    }
    
    override func viewSafeAreaInsetsDidChange() {
        super.viewSafeAreaInsetsDidChange()
        print(#function)
        selfView.searchButtonConstraint = selfView.searchButton.bottomAnchor.constraint(equalTo: view.keyboardLayoutGuide.topAnchor, constant: 600)

        selfView.searchButtonConstraint?.isActive = true
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
        
        selfView.searchBar.rx.searchButtonClicked
            .bind(onNext: {_ in

                self.selfView.searchBar.resignFirstResponder()
                self.selfView.searchButtonConstraint?.constant = 48 + self.selfView.safeAreaInsets.bottom
                
                let vc = SettingViewController()
                self.transition(vc)

            })
            .disposed(by: disposeBag)
        
        
        selfView.searchButton.rx.tap
            .bind(onNext: { _ in
                self.requestQueue()
            })
            .disposed(by: disposeBag)
        
 
        
    }
    
    @objc func keyboardWillShow() {
        
        print("fdsfdsfadsfasfsadfasdfasdfsdfsdfsdf")
        selfView.searchButtonConstraint?.constant = 500
    }
    @objc func keyboardDidHide() {
        
        print("ㅇㄹㄴㅇㄹㄴ함니")
        selfView.searchButtonConstraint?.constant = -48 + -view.safeAreaInsets.bottom
        selfView.searchButtonConstraint = selfView.searchButton.bottomAnchor.constraint(equalTo: view.keyboardLayoutGuide.topAnchor, constant: 50)

        selfView.searchButtonConstraint?.isActive = true
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
            var cnt = 0
            wantedStudyList.forEach {
                cnt += 1
                if $0.id == wanted?.id {
                    wantedStudyList.remove(at: cnt - 1)
                    print("fdfds")
                    
                    
                }
                                            
            }
            

            
            return
        default:
            return
        }
    }
}


extension SearchViewController: UISearchBarDelegate {
    
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
    func requestQueue() {
        self.viewModel.requestQueue {
            switch $0 {
            case .success:
                let vc = SettingViewController()
                self.transition(vc)
                return
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

