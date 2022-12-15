import UIKit

extension UIViewController {
    
    enum TransitionStyle {
        case push
        case present
        case presentfull
        case presentNavigation
        case presentFullNavigation
        case SeSacAlertController
        case toRoot
        case toRootWithNavi
        
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
        case .SeSacAlertController:
            let vc = viewController
            vc.modalPresentationStyle = .overFullScreen
            self.present(vc, animated: true)
        case .toRoot:
            return
        case .toRootWithNavi:
            return
        }
        
    }
    func transitionRootViewController<T: UIViewController>(_ viewController: T,
                                                           transitionStyle: TransitionStyle)
    {
        switch transitionStyle {
        case .toRootWithNavi:
            let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
            let sceneDelegate =  windowScene?.delegate as? SceneDelegate
            let vc = UINavigationController(rootViewController: viewController)
            sceneDelegate?.window?.rootViewController = vc
            sceneDelegate?.window?.makeKeyAndVisible()
            self.present(vc, animated: true)
        case .toRoot:
            let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
            let sceneDelegate =  windowScene?.delegate as? SceneDelegate
            let vc = viewController
            sceneDelegate?.window?.rootViewController = viewController
            sceneDelegate?.window?.makeKeyAndVisible()
            self.present(vc, animated: true)
        default:
            return
        }
    }
    
    func showToastAlert(message: String, completion: @escaping () -> Void) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        self.present(alert, animated: true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
            print("completion")
            self.dismiss(animated: true, completion: completion)
            completion()
            
        }
    }
    
    func showToast(message : String, font: UIFont = SeSacFont.Title4_R14.set) {
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height-100, width: self.view.frame.width, height: self.view.frame.height))
        
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.font = font
        toastLabel.textAlignment = .center
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
        
        
        formatter.dateFormat = "YYYY-MM-dd'T'HH:mm:ss.SSS'Z"
        
        return formatter
    }
    
    func showRequestLocationServiceAlert() {
        let requestLocationServiceAlert = UIAlertController(title: "위치정보 이용", message: "위치 서비스를 사용할 수 없습니다. 기기의 '설정>개인정보 보호'에서 위치 서비스를 켜주세요.", preferredStyle: .alert)
        
        let goSetting = UIAlertAction(title: "설정으로 이동", style: .destructive) { _ in
            if let appSetting = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(appSetting)
            }
        }
        let cancel = UIAlertAction(title: "취소", style: .default)
        requestLocationServiceAlert.addAction(cancel)
        requestLocationServiceAlert.addAction(goSetting)
        present(requestLocationServiceAlert, animated: true, completion: nil)
    }
    
    
    
    
}
