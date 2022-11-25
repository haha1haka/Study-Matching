import UIKit
class SettingViewController: BaseViewController {
    let selfView = SettingView()
    
    override func loadView() { view = selfView }

    
    override func setNavigationBar(title: String, rightTitle: String ) {
        super.setNavigationBar(title: "내정보", rightTitle: "찾기중단")
        
        
        
    }
}

extension SettingViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}
extension SettingViewController {

}

extension SettingViewController {

}
