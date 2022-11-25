import UIKit

class TabBarController: UITabBarController {


    let mapViewController  = UINavigationController(
        rootViewController: MapViewController())
    
    let shopViewController = UINavigationController(
        rootViewController: MyInfoViewController())
    
    let friendViewController = UINavigationController(
        rootViewController: MyInfoViewController())
    
    let myInfoViewController = UINavigationController(
        rootViewController: MyInfoViewController())

    override func viewDidLoad() {
        super.viewDidLoad()
    
        let appearance = UITabBarAppearance()
        appearance.shadowColor = UIColor.clear
        appearance.backgroundColor = .white
        tabBar.standardAppearance = appearance
        tabBar.tintColor = SeSacColor.green
        
        mapViewController.tabBarItem = UITabBarItem(
            title: "홈",
            image: SeSacImage.homeIndAct,
            selectedImage: SeSacImage.homeAct)
        shopViewController.tabBarItem = UITabBarItem(
            title: "새싹샵",
            image: SeSacImage.shopInAct,
            selectedImage: SeSacImage.shopAct)
        friendViewController.tabBarItem = UITabBarItem(
            title: "새싹친구",
            image: SeSacImage.friendInAct,
            selectedImage: SeSacImage.friendAct)
        myInfoViewController.tabBarItem = UITabBarItem(
            title: "내정보",
            image: SeSacImage.ProfileInAct,
            selectedImage: SeSacImage.ProfileAct)
        

        setViewControllers(
            [mapViewController,
             shopViewController,
             friendViewController,
             myInfoViewController],
            animated: true)
        
    }

}
