import UIKit
import RxCocoa
import RxSwift



class MyInfoViewController: BaseViewController {
    let selfView = MyInfoView()
    override func loadView() {
        view = selfView
    }
    lazy var dataSource = MyInfoDataSource(collectionView: selfView.collectionView)

    let viewModel = MyInfoViewModel()
    let disposeBag = DisposeBag()
    
}

extension MyInfoViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource.applySnapshot()
        dataSource.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.fetchUserInfo { result in
            switch result {
            case .success:
                // 데이터 바인드 완료
                return
            case .failure:
                return
            }
        }
    }
}


extension MyInfoViewController: MyInfoDataSourceDelegate  {
    func supplementaryView(_ dataSource: MyInfoDataSource, supplementaryView: MyInfoHeaderView) {
        supplementaryView.nextButton.rx.tap
            .bind(onNext: { _ in
                let vc = ProfileViewController()
                vc.viewModel
                self.transition(vc, transitionStyle: .push)
            })
            .disposed(by: self.disposeBag)
    }
}


