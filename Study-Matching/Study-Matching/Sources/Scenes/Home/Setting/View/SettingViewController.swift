import UIKit
import SnapKit

class SettingViewController: BaseViewController {
    
    let selfView = SettingView()
    
    let pageViewController = SeSacPageViewController(.scroll)

    override func loadView() { view = selfView }
    
    override func setNavigationBar(title: String, rightTitle: String ) {
        super.setNavigationBar(title: "내정보", rightTitle: "찾기중단")
    }
}

extension SettingViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        configurePageViewControllers()
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
