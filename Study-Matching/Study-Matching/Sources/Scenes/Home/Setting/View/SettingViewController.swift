import UIKit
import RxSwift
import RxCocoa
import SnapKit

class SettingViewController: BaseViewController, DataSourceRegistration {
    
    let selfView = SettingView()
    let pageViewController = SeSacPageViewController(.scroll)
    
    let viewModel = SettingViewModel()
    let disposeBag = DisposeBag()
    

        

    override func loadView() { view = selfView }
    
    override func setNavigationBar(title: String, rightTitle: String ) {
        super.setNavigationBar(title: "내정보", rightTitle: "찾기중단")
    }
}

extension SettingViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        pageViewController.eventDelegate = self
        configurePageViewControllers()
        bind()
    }
    func configurePageViewControllers() {
        addChild(pageViewController)
        selfView.addSubview(pageViewController.view)
        pageViewController.view.snp.makeConstraints {
            $0.top.equalTo(selfView.topStackView.snp.bottom)
            $0.leading.trailing.equalTo(selfView.safeAreaLayoutGuide)
            $0.bottom.equalTo(selfView.snp.bottom)
        }
        pageViewController.didMove(toParent: self)
    }
    
}
extension SettingViewController {
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

extension SettingViewController: PageReadable {
    func page(_ viewController: SeSacPageViewController, pageIndex: Int) {
        viewModel.pageIndex.accept(pageIndex)
    }
}
