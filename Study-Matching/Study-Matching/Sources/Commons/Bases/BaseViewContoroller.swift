import UIKit



class BaseViewController: UIViewController {
        
    override func viewDidLoad() {
        super.viewDidLoad()
        configureInit()
        setNavigationBar()
    }
    func configureInit() {}
    
    func setNavigationBar(title: String = "") {
        navigationItem.title = title
        view.backgroundColor = .white
        navigationItem.backButtonTitle = ""
        navigationController?.navigationBar.tintColor = SeSacColor.black
        navigationController?.navigationBar.backIndicatorImage = SeSacImage.arrow
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = SeSacImage.arrow
        let attributedStringKey = [NSAttributedString.Key.font: SeSacFont.Title3_M14.set]
        navigationController?.navigationBar.titleTextAttributes = attributedStringKey
        UIBarButtonItem.appearance().setTitleTextAttributes(attributedStringKey, for: .normal)
        
        

    }
}
