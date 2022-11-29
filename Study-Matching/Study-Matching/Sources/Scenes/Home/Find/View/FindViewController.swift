import UIKit
import RxSwift
import RxCocoa
import SnapKit



class FindViewController: BaseViewController {
    
    let selfView = FindView()
    
    let viewModel = FindViewModel()
    let disposeBag = DisposeBag()
    
    let pageViewController = SeSacPageViewController(.scroll)

    override func loadView() { view = selfView }
    
    override func setNavigationBar(title: String, rightTitle: String ) {
        super.setNavigationBar(title: "내정보", rightTitle: "찾기중단")
    }
}

extension FindViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        embedidIn(pageViewController: pageViewController)
        pageViewController.eventDelegate = self
        bind()
    }
}

extension FindViewController {
    func bind() {
        selfView.nearbyButton.rx.tap
            .bind(onNext: {
                let nearbyViewController = self.pageViewController.pageContentViewControllers[self.selfView.nearbyButton.tag]
                self.pageViewController.setControllers([nearbyViewController])
                
                self.selfView.makeNearbyAct()
            })
            .disposed(by: disposeBag)
        
        selfView.requestedButton.rx.tap
            .bind(onNext: {
                let requestedViewController = self.pageViewController.pageContentViewControllers[self.selfView.requestedButton.tag]
                self.pageViewController.setControllers([requestedViewController])

                self.selfView.makeRequestedAct()
            })
            .disposed(by: disposeBag)
        
        viewModel.pageIndex
            .bind(onNext: {
                switch $0 {
                case .zero:
                    self.selfView.makeNearbyAct()
                default:
                    self.selfView.makeRequestedAct()
                }
            })
            .disposed(by: disposeBag)
    }
}


extension FindViewController: PageReadable {
    func page(_ viewController: SeSacPageViewController, pageIndex: Int) {
        viewModel.pageIndex.accept(pageIndex)
    }
}

extension FindViewController: DataSourceRegistration {}

extension FindViewController: EmbedInPageViewController {}
