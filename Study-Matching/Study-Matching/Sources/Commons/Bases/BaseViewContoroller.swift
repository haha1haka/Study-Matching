import UIKit



class BaseViewController: UIViewController {
    
    typealias MainCellRegistration = UICollectionView.CellRegistration<ProfileMainCell, Main>
    typealias SubCellRegistration = UICollectionView.CellRegistration<ProfileSubCell, Sub>
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureInit()
        setNavigationBar()
    }
    func configureInit() {}
    
    func setNavigationBar() {
        view.backgroundColor = .white
        navigationItem.backButtonTitle = nil
        navigationController?.navigationBar.tintColor = SeSacColor.black
        navigationController?.navigationBar.backIndicatorImage = SeSacImage.arrow
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = SeSacImage.arrow
    }
}
