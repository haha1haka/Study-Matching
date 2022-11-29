
import UIKit

protocol EmbedInPageViewController where Self: UIViewController {
    var selfView: FindView { get }
    func embedidIn(pageViewController: SeSacPageViewController)
}

extension EmbedInPageViewController {
    
    func embedidIn(pageViewController: SeSacPageViewController) {
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
