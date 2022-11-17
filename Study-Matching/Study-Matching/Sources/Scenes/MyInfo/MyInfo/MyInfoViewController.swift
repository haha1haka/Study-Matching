import UIKit
import RxCocoa
import RxSwift



class MyInfoViewController: BaseViewController {
    let selfView = MyInfoView()
    override func loadView() {
        view = selfView
    }
    lazy var dataSource = MyInfoDataSource(collectionView: selfView.collectionView)

    let disposeBag = DisposeBag()
    
}

extension MyInfoViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource.applySnapshot()
        dataSource.delegate = self
    }
}

extension MyInfoViewController: MyInfoDataSourceDelegate  {
    func supplementaryView(_ dataSource: MyInfoDataSource, supplementaryView: MyInfoHeaderView) {
        supplementaryView.nextButton.rx.tap
            .bind(onNext: { _ in
                let vc = ProfileViewController()
                self.transition(vc, transitionStyle: .push)
            })
            .disposed(by: self.disposeBag)
    }
}


