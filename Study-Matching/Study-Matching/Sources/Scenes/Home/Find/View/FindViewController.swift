import UIKit
import RxSwift
import RxCocoa
import SnapKit
import Toast



class FindViewController: BaseViewController, EmbedInPageViewController, DataSourceRegistration {
    
    let selfView = FindView()
    
    override func loadView() { view = selfView }
    
    let viewModel = FindViewModel()
    let disposeBag = DisposeBag()
    
    let pageViewController = SeSacPageViewController(.scroll)
    
    override func setNavigationBar(title: String, rightTitle: String ) {
        super.setNavigationBar(title: "내정보", rightTitle: "찾기중단")
    }
}

extension FindViewController {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.startTimer()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        embedidIn(pageViewController: pageViewController)
        pageViewController.eventDelegate = self
        bind()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        viewModel.stopTimer()
    }
}

extension FindViewController {
    func bind() {
        
        self.navigationItem.rightBarButtonItem?.rx.tap
            .bind(onNext: { [weak self]_ in
                guard let self = self else { return }
                self.requestQueueStop {
                }
            })
            .disposed(by: disposeBag)
        
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

        viewModel.timerFlag
            .bind(onNext: {
                if $0 {
                    self.showToastAlert(message: "매칭 되었습니다. 채팅으로 이동") {
                        let vc = ChatViewController()
                        self.transition(vc)
                        self.viewModel.stopTimer()
                    }
                }
            })
            .disposed(by: disposeBag)
    }
}

extension FindViewController {
    func requestQueueStop(completion: @escaping () -> Void) {
        self.viewModel.requestQueueStop {
            switch $0 {
            case .success:
                self.toMapViewController()
                return
            case .failure(let error):
                switch error {
                case .idTokenError:
                    self.requestQueueStop{}
                default:
                    return
                }
            }
        }
        
    }
}




extension FindViewController {
    func toMapViewController() {
        if let vc = self.navigationController?.viewControllers.last(where: { $0.isKind(of: MapViewController.self) }) {
            self.navigationController?.popToViewController(vc, animated: true)
        }
    }
}


extension FindViewController: PageReadable {
    func page(_ viewController: SeSacPageViewController, pageIndex: Int) {
        viewModel.pageIndex.accept(pageIndex)
    }
}
