import UIKit
class SettingViewController: BaseViewController, UIPageViewControllerDelegate {
    
    let selfView = SettingView()
    
    lazy var pageViewController: UIPageViewController = {
        let pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
        
        //pageViewController.dataSource = self
        
        pageViewController.setViewControllers([], direction: .forward, animated: true)
        return pageViewController
    }()

    
    override func loadView() { view = selfView }
    
    override func setNavigationBar(title: String, rightTitle: String ) {
        super.setNavigationBar(title: "내정보", rightTitle: "찾기중단")
    }
}

extension SettingViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}
//extension SettingViewController: UIPageViewControllerDataSource {
//    func pageViewController(_ pageViewController: UIPageViewController,
//                            viewControllerBefore viewController: UIViewController) -> UIViewController? {
//        //pageViewController.viewControllers?.firstIndex(of: viewController)
//        if let currentIndex = pageContentViewControllers.firstIndex(of: viewController) {
//            if currentIndex > 0 {
//                return pageContentViewControllers[currentIndex-1]
//            }
//        }
//        return nil
//    }
//
//    func pageViewController(_ pageViewController: UIPageViewController,
//                            viewControllerAfter viewController: UIViewController) -> UIViewController? {
//        if let currentIndex = pageContentViewControllers.firstIndex(of: viewController) {
//            if currentIndex < pageContentViewControllers.count - 1 {
//                return pageContentViewControllers[currentIndex+1]
//            }
//        }
//        return nil
//    }
//
//
//}

extension SettingViewController {

}
