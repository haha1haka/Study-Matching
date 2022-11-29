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
        
        mainCell = CardCellRegistration
        { [weak self] cell, indexPath, itemIdentifier in
            guard let self = self else { return }
            
            // MARK: - 김새싹
            self.viewModel.cardList
//                .skip(1)
                .bind(onNext: {
                    $0.forEach {
                        print("💟💟💟\($0.nick)")
                        cell.nameLabel.text = $0.nick
                        cell.textField.text = $0.reviews.first ?? "첫 리뷰를 기다리는 중이에요~!"
                    }
                })
                .disposed(by: self.disposeBag)
            
            
            self.viewModel.sesacFriendDataStore.value.fromQueueDB.forEach {
                var arr: [Card] = []
                arr.append(Card(nick: $0.nick, reputation: $0.reputation, studyList: $0.studylist, reviews: $0.reviews, gender: $0.gender, type: $0.type, sesac: $0.sesac, background: $0.background))
            }
            
            
            
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
            
//            self.viewModel.reviews
//                .bind(onNext: {
//                    if $0.isEmpty {
//                        cell.textField.placeholder = "첫 리뷰를 기다리는 중이에요~!"
//                    } else {
//                        cell.textField.text = $0.first ?? ""
//                    }
//                })
//                .disposed(by: self.disposeBag)
        }
        
        
        
        
        viewModel.sesacFriendDataStore
            .bind(onNext: {
                var arr: [Section] = []
                
                
                $0.fromQueueDB.forEach {
                    print("✅",$0)
                    var section = Section(label: $0.uid)
                    var snapshot = self.dataSource.snapshot()
                    snapshot.appendSections([section])
                    snapshot.appendItems(self.viewModel.cardList.value)
                    self.dataSource.apply(snapshot)
                }
                print(arr)
                
                
            })
            .disposed(by: disposeBag)
    }
}







extension NearbyViewController: DataSourceRegistration {}

extension NearbyViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        
//        if collectionView.indexPathsForSelectedItems?.contains(indexPath) ?? false {
//            collectionView.deselectItem(at: indexPath, animated: true)
//        } else {
//            collectionView.selectItem(at: indexPath, animated: true, scrollPosition: [])
//        }
        
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
