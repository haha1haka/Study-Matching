
    // MARK: - SceneDelegate
    //import UIKit
    //
    //class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    //
    //    var window: UIWindow?
    //
    //    func scene(_ scene: UIScene,
    //               willConnectTo session: UISceneSession,
    //               options connectionOptions: UIScene.ConnectionOptions)
    //    {
    //        guard let scene = (scene as? UIWindowScene) else { return }
    //        window = UIWindow(windowScene: scene)
    //        window?.rootViewController = TabBarController()
    //        window?.makeKeyAndVisible()
    //    }
    //}


    // MARK: - ViewController
    //import UIKit
    //class MainViewController: BaseViewController {
    //    let selfView = MainView()
    //    override func loadView() {
    //        view = selfView
    //    }
    //}
    //
    //extension MainViewController {
    //    override func viewDidLoad() {
    //        super.viewDidLoad()
    //    }
    //}
    //extension MainViewController {
    //
    //}
    //
    //extension MainViewController {
    //
    //}



    // MARK: - View
    //import UIKit
    //class MainView: BaseView {
    //
    //
    //    override func configureHierarchy() {
    //        <#code#>
    //    }
    //    override func configureLayout() {
    //        <#code#>
    //    }
    //    override func configureAttributes() {
    //        <#code#>
    //    }
    //
    //}



    // MARK: - Cell
    //import UIKit

    //class MainCell: BaseCollectionViewCell {
    //    override func configureHierarchy() {
    //        <#code#>
    //    }
    //    override func configureLayout() {
    //        <#code#>
    //    }
    //    override func configureAttributesInit() {
    //        <#code#>
    //    }
    //}



    // MARK: - navigationBar
    //func configureNavigationBar() {
    //    self.navigationItem.title = "😃😃😃😃😃"
    //    let appearance = UINavigationBarAppearance()
    //    appearance.shadowColor = .clear
    //    appearance.backgroundColor = .systemGreen
    //    appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
    //    navigationItem.standardAppearance = appearance
    //    navigationItem.scrollEdgeAppearance = appearance
    //}




    // MARK: - TabBar
    //import UIKit
    //
    //class TabBarController: UITabBarController {
    //
    //
    //    let mainViewController = UINavigationController(rootViewController: MainViewController())
    //    let searchViewController = UINavigationController(rootViewController: SearchViewContoller())
    //    let albumViewController = UINavigationController(rootViewController: AlbumViewController())
    //
    //    override func viewDidLoad() {
    //        super.viewDidLoad()
    //        navigationController?.navigationBar.isHidden = true
    //        tabBar.tintColor = .black
    //        tabBar.unselectedItemTintColor = .lightGray
    //        mainViewController.tabBarItem.image = UIImage(systemName: "photo")
    //        searchViewController.tabBarItem.image = UIImage(systemName: "magnifyingglass")
    //        albumViewController.tabBarItem.image = UIImage(systemName: "person.crop.circle.fill")
    //        viewControllers = [mainViewController, searchViewController, albumViewController]
    //    }
    //
    //}
