import UIKit
import SnapKit

class HomeViewController: BaseViewController {
    let selfView = HomeView()
    override func loadView() {
        view = selfView
    }
    
    let button = SeSacButton()
    
    let viewModel = HomeViewModel()
    
}

extension HomeViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        selfView.addSubview(button)
        
        button.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(selfView.safeAreaLayoutGuide).inset(20)
        }
        
        
        

        
    }
}
extension HomeViewController {
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

extension HomeViewController {

}
