import UIKit

class RequestedViewController: BaseViewController {
    
    let selfView = RequestedView()
    
    override func loadView() { view = selfView }
}

extension RequestedViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
