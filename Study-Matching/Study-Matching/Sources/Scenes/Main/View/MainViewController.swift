import UIKit
import SnapKit

class MainViewController: BaseViewController {
    let selfView = MainView()
    override func loadView() {
        view = selfView
    }
    
    let button = SeSacButton()
    
    let viewModel = MainViewModel()
    
}

extension MainViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        selfView.addSubview(button)
        
        button.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(selfView.safeAreaLayoutGuide).inset(20)
        }
        
        
        

        
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
