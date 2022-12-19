import UIKit

protocol PageReadable {
    func page(_ viewController: SeSacPageViewController, pageIndex: Int)
}

class SeSacPageViewController: UIPageViewController {
    
    let nearbyViewController = NearbyViewController()
    let requestedViewController = RequestedViewController()
    let viewModel = FindViewModel()
    var pageContentViewControllers: [UIViewController] = []
    
    var eventDelegate: PageReadable?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        dataSource = self
        pageContentViewControllers = [nearbyViewController, requestedViewController]
        setViewControllers([nearbyViewController], direction: .forward, animated: false)
    }
    
    convenience init(_ transitionStyle: UIPageViewController.TransitionStyle = .scroll) {
        self.init(transitionStyle: transitionStyle, navigationOrientation: .horizontal)
    }
}

extension SeSacPageViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerBefore viewController: UIViewController) -> UIViewController?
    {
        print("fdsfdsfd")
        if let currentIndex = pageContentViewControllers.firstIndex(of: viewController) {
            if currentIndex > 0 {
                return pageContentViewControllers[currentIndex-1]
            }
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerAfter viewController: UIViewController) -> UIViewController?
    {
        print("ㅇㅇㅇ아ㅡ아느")
        if let currentIndex = pageContentViewControllers.firstIndex(of: viewController) {
            if currentIndex < pageContentViewControllers.count - 1 {
                return pageContentViewControllers[currentIndex+1]
            }
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            didFinishAnimating finished: Bool,
                            previousViewControllers: [UIViewController], transitionCompleted completed: Bool)
    {
        guard completed else { return }
        if let currentViewController = pageViewController.viewControllers?.first!,
           let currentIndex = pageContentViewControllers.firstIndex(of: currentViewController) {
            self.eventDelegate?.page(self, pageIndex: currentIndex)
        }
    }
}

extension SeSacPageViewController {
    func setControllers(_ viewControllers: [UIViewController],_ direction: UIPageViewController.NavigationDirection = .forward) {
        setViewControllers(viewControllers, direction: direction, animated: false)
    }
}
