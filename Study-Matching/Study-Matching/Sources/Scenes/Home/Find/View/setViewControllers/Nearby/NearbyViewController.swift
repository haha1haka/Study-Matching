import UIKit
import RxSwift
import RxCocoa



class NearbyViewController: BaseViewController, DataSourceRegistration {
    
    let emptyView = EmptyView()
    let cardView = CardCollectionView()
    
    override func loadView() { view = emptyView }
    
    let viewModel = FindViewModel()
    let disposeBag = DisposeBag()
    
    var header: CardHeaderRegistration?
    var mainCell: CardCellRegistration?
    
    lazy var dataSource = CardCollectionDataSource(
        collectionView      : cardView.collectionView,
        headerRegistration  : self.header!,
        mainCellRegistration: self.mainCell!)
}

extension NearbyViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.requestQueueSearch{ }
    }
    
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
}

extension NearbyViewController {
    func bind() {
        
        
        header = CardHeaderRegistration (elementKind: UICollectionView.elementKindSectionHeader)
        { [weak self] supplementaryView, elementKind, indexPath in
            guard let self = self else { return }
            supplementaryView.requestButton.tag = indexPath.section
            guard let item = self.dataSource.itemIdentifier(for: indexPath) else { return }
            
            
            self.viewModel.cardItemList
                .bind(onNext: { _ in
                    supplementaryView.mainImageView.image = SeSacImage.sesacBackgroundImageArray[item.background]
                    supplementaryView.subImageView.image = SeSacImage.sesacImageArray[item.sesac]
                    supplementaryView.requestButton.tag = indexPath.section
                    
                })
                .disposed(by: self.disposeBag)
            supplementaryView.requestButton.addTarget(self, action: #selector(self.tappedRequestButton), for: .touchUpInside)
        }

        mainCell = CardCellRegistration
        {  cell, indexPath, itemIdentifier in
            cell.configureCell(with: itemIdentifier)
        }
        
        self.viewModel.cardItemList

            .bind(onNext: { cards in
                var snapShot = self.dataSource.snapshot()
                snapShot.deleteAllItems()
                for i in cards {
                    let currentSection = Section(label: "\(i.uid)")
                    snapShot.appendSections([currentSection])
                    snapShot.appendItems([i], toSection: currentSection)
                    self.dataSource.apply(snapShot)
                }
            })
            .disposed(by: self.disposeBag)
    }
    
    @objc
    func tappedRequestButton(_ button: UIButton) {
        
        let vc = SeSacAlertController(alertType: .findNearby)
        vc.completeButton.rx.tap
            .bind(onNext: {
                let item = self.viewModel.cardItemList.value[button.tag]
                self.requestStudy(uid: item.uid)
                print("🐶🐶🐶🐶\(item.nick)")
            })
            .disposed(by: disposeBag)
        
        vc.cancelButton.rx.tap
            .bind(onNext: {
                vc.dismiss(animated: false)
            })
            .disposed(by: disposeBag)
        self.transition(vc, transitionStyle: .SeSacAlertController)
    }
}


extension NearbyViewController {
    func requestStudy(uid: String) {
        self.viewModel.requestStudy(uid: uid) {
            switch $0 {
            case .success(let success):
                switch success {
                case .perfact:
                    print("성공적으로 스터디 요청을 보냈습니다")
                case .alreadyRequested:
                    self.requestStudyAccept(uid: uid)
                    return
                default:
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
    
    func requestStudyAccept(uid: String) {
        self.viewModel.requestStudyAccept(uid: uid) {
            switch $0 {
            case .success(let success):
                switch success {
                case .perfact:
                    print("매칭 성공")
                    let vc = ChatViewController()
                    self.transition(vc)
                case .alreadyMatching:
                    print("상대방이 이미 다른 새싹과 스터디를 함께 하는 중입니다")
                case .searchStoping:
                    print("상대방이 스터디 찾기를 그만 두었습니다.")
                case .someoneWhoLikesMe:
                    print("앗! 누군가가 나의 스터디를 수락 하였어요!")
                default:
                    return
                }
            case .failure(let error):
                switch error {
                case .idTokenError:
                    self.requestStudyAccept(uid: uid)
                    return
                case .unRegistedUser:
                    print("미가입 유저")
                    return
                default:
                    return
                }
            }
        }
    }
}

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
