import UIKit
import RxSwift
import RxCocoa



class NearbyViewController: BaseViewController {
    
    let emptyView = EmptyView()
    let cardView = CardCollectionView()
    
    let viewModel = FindViewModel()
    let disposeBag = DisposeBag()
    
    var header: CardHeaderRegistration?
    var mainCell: CardCellRegistration?
    
    lazy var dataSource = CardCollectionDataSource(
        collectionView      : cardView.collectionView,
        headerRegistration  : self.header!,
        mainCellRegistration: self.mainCell!)
    
    override func loadView() { view = emptyView }
    
}


extension NearbyViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cardView.collectionView.delegate = self
        bind()
        
        if !viewModel.fromQueueDBisEmpty {
            view = emptyView
        } else {
            view = cardView
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.requestQueueSearch{ }
    }
    
}

extension NearbyViewController {
    func bind() {
        
        
        header = CardHeaderRegistration (elementKind: UICollectionView.elementKindSectionHeader)
        { [weak self] supplementaryView, elementKind, indexPath in
            guard let self = self else { return }
            
            self.viewModel.cardItemList
                .bind(onNext: { _ in
                    guard let item = self.dataSource.itemIdentifier(for: indexPath) else { return }
                    
                    supplementaryView.mainImageView.image = SeSacImage.sesacBackgroundImageArray[item.background]
                    supplementaryView.subImageView.image = SeSacImage.sesacImageArray[item.sesac]
                    
                })
                .disposed(by: self.disposeBag)
            
            supplementaryView.requestButton.rx.tap
                .bind(onNext: {
                    
                    let vc = SeSacAlertController()
                    
                    vc.completeButton.rx.tap
                        .bind(onNext: {
                            // MARK: - todo: 요청 하기 api 실행
                            
                            
                        })
                        .disposed(by: self.disposeBag)
                    
                    
                    vc.cancelButton.rx.tap
                        .bind(onNext: {
                            vc.dismiss(animated: false)
                        })
                        .disposed(by: self.disposeBag)
                    
                    vc.transition(vc, transitionStyle: .SeSacAlertController)
                })
                .disposed(by: self.disposeBag)
                
        }
        
        mainCell = CardCellRegistration
        { [weak self] cell, indexPath, itemIdentifier in
            guard let self = self else { return }
            cell.configureCell(with: itemIdentifier)
        }
        
        
        
        self.viewModel.cardItemList //[Card]
            .bind(onNext: { cards in
                for i in cards {
                    let currentSection = Section(label: "\(i.nick)")
                    var snapShot = self.dataSource.snapshot()
                    snapShot.appendSections([currentSection])
                    snapShot.appendItems([i], toSection: currentSection)
                    self.dataSource.apply(snapShot)
                }


            })
            .disposed(by: self.disposeBag)

    }
}


extension NearbyViewController {
    func requestStudy(uid: String) {
        self.viewModel.requestStudy(uid: uid) {
            switch $0 {
            case .success(let success):
                switch success {
                case .perfact:
                    print("스터디 요청을 보냈습니다")
                case .alreadyRequested:
                    // MARK: - studyAccept api 호출
                    return 
                }
            case .failure(let error):
                switch error {
                case .searchStop:
                    self.showToast(message: "상대방이 스터디 찾기를 그만 두었습니다")
                case .idTokenError:
                    self.requestStudy(uid: uid)
                    return
                default:
                    return
                }
            }
        }
    }
}




extension NearbyViewController: DataSourceRegistration {}

extension NearbyViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        
        if collectionView.indexPathsForSelectedItems?.contains(indexPath) ?? false {
            collectionView.deselectItem(at: indexPath, animated: true)
        } else {
            collectionView.selectItem(at: indexPath, animated: true, scrollPosition: [])
        }
        
        dataSource.refresh()
        
        return false
    }
    
    
}


extension NearbyViewController {
    func requestQueueSearch(completion: @escaping () -> Void) {
        self.viewModel.requestQueueSearch {
            switch $0 {
            case .success:
                print("완료")
                completion()
                return
            case .failure(let error):
                switch error {
                case .idTokenError:
                    self.requestQueueSearch{}
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
