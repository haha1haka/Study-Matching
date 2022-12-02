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
        } else {
            view = cardView
        }
                
        bind()
        
        //dataSource.applySnapshot()
        
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
        
        }
        
        mainCell = CardCellRegistration
        { [weak self] cell, indexPath, itemIdentifier in
            guard let self = self else { return }
            cell.reviewButton.rx.tap
                .bind(onNext: {
                    let vc = ReviewViewContoller()
                    self.transition(vc)
                })
                .disposed(by: self.disposeBag)

        }
        
        self.viewModel.lat
            .bind(onNext: {
            print("🐙\($0)")
        })
            .disposed(by: disposeBag)
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
