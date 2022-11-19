import UIKit
import RxCocoa
import RxSwift



class MyInfoViewController: BaseViewController {
    let selfView = MyInfoView()
    override func loadView() {
        view = selfView
    }
    lazy var dataSource = MyInfoDataSource(collectionView: selfView.collectionView)

    let viewModel = MyInfoViewModel.shared
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
            case .success: // 데이터 바인드 완료
                print("바인드 완료")
                print(self.viewModel.user.value)
            case .failure:
                return
            }
        }


    }
}


extension MyInfoViewController: MyInfoDataSourceDelegate  {
    func supplementaryView(_ dataSource: MyInfoDataSource, supplementaryView: MyInfoHeaderView) {
        

        viewModel.nick
            .bind(to: supplementaryView.label.rx.text)
            .disposed(by: disposeBag)
            
        
        
        supplementaryView.nextButton.rx.tap
            .bind(onNext: { _ in
                let vc = ProfileViewController()
                self.transition(vc, transitionStyle: .push)
            })
            .disposed(by: self.disposeBag)
    }
}


