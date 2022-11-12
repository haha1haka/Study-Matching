import UIKit
import RxSwift
import RxCocoa

class SMSViewController: BaseViewController {
    let selfView = SMSView()
    override func loadView() {
        view = selfView
    }
    let viewModel = AuthViewModel()
    let disposeBag = DisposeBag()
}

extension SMSViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
extension SMSViewController {

}

extension SMSViewController {

}
