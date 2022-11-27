import UIKit
import RxSwift
import RxCocoa

struct Section: Hashable {
    let uuid = UUID()
    let label: String
}




class NearbyViewController: BaseViewController, DataSourceRegistration {
    
    let emptyView = NearbyView()
    let isView = RequestedView()
    
    override func loadView() { view = emptyView }
    let viewModel = NearbyViewModel()
    let disposeBag = DisposeBag()
    var header: RequestedHeadRegistration?
    var mainCell: RequestedCellRegistration?
    
    lazy var dataSource = RequestedDataSource(
        collectionView      : isView.collectionView,
        headerRegistration  : self.header!,
        mainCellRegistration: self.mainCell!)
    
}


extension NearbyViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        isView.collectionView.delegate = self
        if !viewModel.sesacFriendDataStore.value.fromQueueDB.isEmpty {
            view = emptyView
        } else {
            view = isView
        }
        bind()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.requestQueueSearch()
        
    }
    
}

extension NearbyViewController {
    func bind() {
        
        
        header = RequestedHeadRegistration (elementKind: UICollectionView.elementKindSectionHeader)
        { [weak self] supplementaryView, elementKind, indexPath in
            guard let self = self else { return }
            
            self.viewModel.background
                .bind(onNext: { int in
                    if int == 0 {
                        supplementaryView.mainImageView.image = SeSacImage.sesacBg01
                    }
                })
                .disposed(by: self.disposeBag)
            
            self.viewModel.sesac
                .bind(onNext: { int in
                    if int == 0 {
                        supplementaryView.subImageView.image = SeSacImage.sesacFace2
                    }
                })
                .disposed(by: self.disposeBag)

        }
        
        mainCell = RequestedCellRegistration
        { [weak self] cell, indexPath, itemIdentifier in
            guard let self = self else { return }
    
            // MARK: - 김새싹
            self.viewModel.nick
                .bind(to: cell.nameLabel.rx.text)
                .disposed(by: self.disposeBag)
            

            // MARK: - 버튼 6개
//            self.viewModel.reputation
//                .bind(onNext: { arr in
//                    [cell.cardStackView.button0,
//                     cell.cardStackView.button1,
//                     cell.cardStackView.button2,
//                     cell.cardStackView.button3,
//                     cell.cardStackView.button4,
//                     cell.cardStackView.button5]
//                    .forEach {
//                        if !(arr[$0.tag] == 0) {
//                            $0.toAct
//                        }
//                    }
//            })
//                .disposed(by: self.disposeBag)
            // MARK: - 리뷰
            
            self.viewModel.reviews
                .bind(onNext: {
                    if $0.isEmpty {
                        cell.textField.placeholder = "첫 리뷰를 기다리는 중이에요~!"
                    } else {
                        cell.textField.text = $0.first ?? ""
                    }
                })
                .disposed(by: self.disposeBag)
        }

        
        
        
        viewModel.sesacFriendDataStore
            .bind(onNext: {
                var arr: [Section] = []
                
                $0.fromQueueDB.forEach {
                    print("✅",$0)
                    var section = Section(label: $0.uid)
                    var snapshot = self.dataSource.snapshot()
                    snapshot.appendSections([section])
                    snapshot.appendItems([Main()])
                    self.dataSource.apply(snapshot)
                }
                print(arr)


            })
            .disposed(by: disposeBag)
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
    func requestQueueSearch() {
        self.viewModel.requestQueueSearch {
            switch $0 {
            case .success:
                print("완료")
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
