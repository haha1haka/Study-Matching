import UIKit

class NearbyViewController: BaseViewController {
    
    let selfView = NearbyView()
    
    override func loadView() { view = selfView }
}

extension NearbyViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

