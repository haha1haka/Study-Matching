import UIKit

class FakerViewController: BaseViewController {
    let selfView = FakerView()
    override func loadView() {
        view = selfView
    }
}

extension FakerViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sleep(3)
        
        coordinator()
    }
}
extension FakerViewController {
    func coordinator() {
        if UserDefaultsManager.standard.idToken.isEmpty {
            // 로그인 -> 회원가입
            let vc = AuthViewController()
            self.transition(vc, transitionStyle: .present)
            
        } else {
            //로그인 요청
            
        }
    }

}

extension FakerViewController {

}
