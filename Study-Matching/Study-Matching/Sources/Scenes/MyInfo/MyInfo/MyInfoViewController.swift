import UIKit
import RxCocoa
import RxSwift


class MyInfoViewController: BaseViewController, DataSourceRegistration {
    let selfView = MyInfoView()
    override func loadView() {
        view = selfView
    }
    var `cell`: MyInfoCellRegistration?
    var header: MyInfoHeaderRegistration?
    
    lazy var dataSource = MyInfoDataSource(
        collectionView:     selfView.collectionView,
        headerRegistration: self.header!,
        cellRegistration:   self.cell!)
    
    let viewModel = MyInfoViewModel.shared
    let disposeBag = DisposeBag()
    
    override func setNavigationBar(title: String) {
        super.setNavigationBar(title: "내정보")
    }
    
}

extension MyInfoViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        dataSource.applySnapshot()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.fetchUserInfo { result in
            switch result {
            case .success:
                print("⭐️바인드 완료")
                print(self.viewModel.user.value!)
            case .failure(let error):
                switch error {
                default:
                    return
                }
            }
        }
        
        
    }
}


extension MyInfoViewController  {
    func bind() {
        `cell` = MyInfoCellRegistration{ cell, indexPath, itemIdentifier in
            cell.configure(with: itemIdentifier)
        }
        
        header = MyInfoHeaderRegistration(elementKind: UICollectionView.elementKindSectionHeader) { [weak self] supplementaryView, elementKind, indexPath in
            guard let self = self else { return }
            
            self.viewModel.nick
                .bind(to: supplementaryView.label.rx.text)
                .disposed(by: self.disposeBag)
            
            supplementaryView.nextButton.rx.tap
                .bind(onNext: { _ in
                    let vc = ProfileViewController()
                    self.transition(vc, transitionStyle: .push)
                })
                .disposed(by: self.disposeBag)
        }
        
        
    }
}


