import UIKit
import RxSwift
import RxCocoa
import SnapKit

class SettingViewController: BaseViewController {
    
    let selfView = SettingView()
    
    let pageViewController = SeSacPageViewController(.scroll)
    let disposeBag = DisposeBag()

    override func loadView() { view = selfView }
    
    override func setNavigationBar(title: String, rightTitle: String ) {
        super.setNavigationBar(title: "내정보", rightTitle: "찾기중단")
    }
}

extension SettingViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
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
                self.pageViewController.setViewControllers([self.pageViewController.pageContentViewControllers[self.selfView.nearbyButton.tag]], direction: .forward, animated: false)
                
                //self.selfView.nearbyButton.toactti
            })
            .disposed(by: disposeBag)
        
        selfView.requestedButton.rx.tap
            .bind(onNext: {
                self.pageViewController.setViewControllers([self.pageViewController.pageContentViewControllers[self.selfView.requestedButton.tag]], direction: .forward, animated: false)
            })
            .disposed(by: disposeBag)
        
        
    }
}
