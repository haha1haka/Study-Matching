import UIKit

class TabBarController: UITabBarController {


    let homeViewController = UINavigationController(rootViewController: MainViewController())
    let shopViewController = UINavigationController(rootViewController: MainViewController())
    let friendViewController = UINavigationController(rootViewController: MainViewController())
    let myInfoViewController = UINavigationController(rootViewController: MyInfoViewController())

    override func viewDidLoad() {
        super.viewDidLoad()
    
        let appearance = UITabBarAppearance()
        appearance.shadowColor = UIColor.clear
        appearance.backgroundColor = .white
        tabBar.standardAppearance = appearance
        tabBar.tintColor = SeSacColor.green

        
        homeViewController.tabBarItem = UITabBarItem(title: "홈", image: SeSacImage.homeIndAct, selectedImage: SeSacImage.homeAct)
        shopViewController.tabBarItem = UITabBarItem(title: "새싹샵", image: SeSacImage.shopInAct, selectedImage: SeSacImage.shopAct)
        friendViewController.tabBarItem = UITabBarItem(title: "새싹친구", image: SeSacImage.friendInAct, selectedImage: SeSacImage.friendAct)
        myInfoViewController.tabBarItem = UITabBarItem(title: "내정보", image: SeSacImage.ProfileInAct, selectedImage: SeSacImage.ProfileAct)
        

        setViewControllers([homeViewController, shopViewController, friendViewController, myInfoViewController], animated: true)
        
    }

}
