import UIKit
import RxSwift
import RxCocoa

class RequestedViewController: BaseViewController, DataSourceRegistration {
    

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

extension RequestedViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cardView.collectionView.delegate = self
        
        if !viewModel.fromQueueDBisEmpty {
            view = emptyView
        } else { //⚠️개선
            view = cardView
        }
                
        bind()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.requestQueueSearch { }
        
    }

}

extension RequestedViewController {
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
        
        self.viewModel.requestedCardItemList //[Card]
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
        
        let alertVC = SeSacAlertController(alertType: .findNearby)
        alertVC.completeButton.rx.tap
            .bind(onNext: {
                
                DispatchQueue.main.async {
                    let vc = ChatViewController()
                    
                    let item = self.viewModel.requestedCardItemList.value[button.tag]
                    print("⭐️\(item.uid)")
                    

                    self.viewModel.requestStudyAccept(uid: item.uid) {
                        switch $0 {
                        case .success:
                            print("매칭 수락됨")
                        case .failure:
                            return
                        
                        }
                    }

                    
                    alertVC.dismiss(animated: true) {
                        self.transition(vc)
                    }
                    

                }
                            })
            .disposed(by: disposeBag)
        
        alertVC.cancelButton.rx.tap
            .bind(onNext: {
                alertVC.dismiss(animated: false)
            })
            .disposed(by: disposeBag)
        
        self.transition(alertVC, transitionStyle: .SeSacAlertController)
    }
    
}
extension RequestedViewController: UICollectionViewDelegate {
    
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

extension RequestedViewController {
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
