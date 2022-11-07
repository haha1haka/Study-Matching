import UIKit

class MainViewController: BaseViewController {
    let selfView = MainView()
    override func loadView() {
        view = selfView
    }
    
    let viewModel = MainViewModel()
    
}

extension MainViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
    }
}
extension MainViewController {
    func configureNavigationBar() {
        self.navigationItem.title = "Welcome!!"
        let appearance = UINavigationBarAppearance()
        appearance.shadowColor = .clear
        appearance.backgroundColor = .systemGreen
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationItem.standardAppearance = appearance
        navigationItem.scrollEdgeAppearance = appearance
    }
}

extension MainViewController {

}
