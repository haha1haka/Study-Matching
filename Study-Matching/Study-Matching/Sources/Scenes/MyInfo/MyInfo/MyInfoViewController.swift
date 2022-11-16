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
    }
}




