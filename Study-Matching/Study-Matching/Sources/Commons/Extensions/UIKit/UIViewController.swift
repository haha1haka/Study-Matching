import UIKit

extension UIViewController {
    
    enum TransitionStyle {
        case push
        case present
        case presentfull
        case presentNavigation
        case presentFullNavigation
        
    }
    
    func transition<T: UIViewController>(_ viewController: T,
                                         transitionStyle: TransitionStyle = .push)
    {
        switch transitionStyle {
            
        case .push:
            self.navigationController?.pushViewController(viewController, animated: true)
        case .present:
            self.present(viewController, animated: true)
        case .presentfull:
            self.modalTransitionStyle = .coverVertical
            self.modalPresentationStyle = .fullScreen
            
            self.present(viewController, animated: true)
        case .presentNavigation:
            let navi = UINavigationController(rootViewController: viewController)
            
            self.present(navi, animated: true)
        case .presentFullNavigation:
            let navi = UINavigationController(rootViewController: viewController)
            navi.modalPresentationStyle = .fullScreen
            self.present(navi, animated: true)
        }
    }
    func transitionRootViewController<T: UIViewController>(_ viewController: T,
                                         transitionStyle: TransitionStyle = .presentNavigation)
    {
        switch transitionStyle {
        case .presentNavigation:
            let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
            let sceneDelegate =  windowScene?.delegate as? SceneDelegate
            let navi = UINavigationController(rootViewController: viewController)
            sceneDelegate?.window?.rootViewController = navi
            sceneDelegate?.window?.makeKeyAndVisible()
            self.present(navi, animated: true)
        default:
            return
        }
    }
    

    func showToast(message : String, font: UIFont = UIFont.systemFont(ofSize: 14.0)) {
         let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height-100, width: 150, height: 35))
         toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
         toastLabel.textColor = UIColor.white
         toastLabel.font = font
         toastLabel.textAlignment = .center;
         toastLabel.text = message
         toastLabel.alpha = 1.0
         toastLabel.layer.cornerRadius = 10;
         toastLabel.clipsToBounds  =  true
         self.view.addSubview(toastLabel)
         UIView.animate(withDuration: 3.0, delay: 0.1, options: .curveEaseOut, animations: {
              toastLabel.alpha = 0.0
         }, completion: {(isCompleted) in
             toastLabel.removeFromSuperview()
         })
    }
    
    
    var dateformatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "YYYY-MM-DDTHH:mm:ss.SSSZ"
        return formatter
    }
    
}
