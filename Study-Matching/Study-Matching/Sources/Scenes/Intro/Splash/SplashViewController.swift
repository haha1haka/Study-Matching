import UIKit



enum SceneType: String {
    case onboarding
    case auth
    case nick
    case home
}


class SplashViewController: BaseViewController {
    
    let selfView = SplashView()
    
    override func loadView() { view = selfView }
    
    deinit {
        print("SplashViewController - deinit")
    }
}

extension SplashViewController {
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        /// 로그인 하고 나갔다 온 경우 대응
        if UserDefaultsManager.standard.smsFlag {
            
            UserDefaultsManager.standard.smsFlag = false
            let vc = NicknameViewController()
            self.transitionRootViewController(vc, transitionStyle: .toRootWithNavi)
            
        } else {
            
            sleep(3)
            
            saveSceneType {
                DispatchQueue.main.async {
                    self.coordinator()
                }
                
                
                
            }
        }
    }
}

extension SplashViewController {
    
    func saveSceneType(completion: @escaping () -> Void) {
        print("❌\(UserDefaultsManager.standard.onboardFlag)")

        ///최초 이후 화면 전환 로직 처리
        if UserDefaultsManager.standard.onboardFlag {

            if UserDefaultsManager.standard.idToken == "" {

                UserDefaultsManager.standard.coordinator = SceneType.auth.rawValue
                completion()
            } else {
                requestGetUser {
                    completion()
                }
                
            }
            
        } else { ///최초에 무조건 온보딩으로 가기

            print("❌\(UserDefaultsManager.standard.onboardFlag)")

            UserDefaultsManager.standard.coordinator = SceneType.onboarding.rawValue
            
            completion()

        }

    }
    
    
    func coordinator() {
        let coordinator = UserDefaultsManager.standard.coordinator
        let firstScene = SceneType(rawValue: coordinator)
        print("✨\(coordinator)")
        
            switch firstScene {
            case .onboarding:
                let vc = OnBoardingViewController()
                self.transitionRootViewController(vc, transitionStyle: .toRootWithNavi)
            case .auth:
                let vc = AuthViewController()
                self.transitionRootViewController(vc, transitionStyle: .toRootWithNavi)

            case .nick:
                let vc = NicknameViewController()
                self.transitionRootViewController(vc, transitionStyle: .toRootWithNavi)

            case .home:
                let vc = TabBarController()
                self.transitionRootViewController(vc, transitionStyle: .toRoot)

            default:
                return
            }
        

    }
}

extension SplashViewController {
    func requestGetUser(completion: @escaping () -> Void) {
        MemoleaseService.shared.requestGetUser(target: UserRouter.signIn) { result in
            switch result {
            case .success:
                UserDefaultsManager.standard.coordinator = SceneType.home.rawValue
                completion()
            case .failure(let error):
                switch error {
                case .idTokenError:
                    self.requestGetUser { }
                    
                case .unRegistedUser:
                    UserDefaultsManager.standard.coordinator = SceneType.nick.rawValue
                    completion()
                case .serverError:
                    self.showToastAlert(message: "서버 점검중 입니다. 다음에 시도해 주세요", completion: {})
                    
                case .clientError:
                    self.showToastAlert(message: "서버 점검중 입니다. 다음에 시도해 주세요", completion: {})
                    
                default:
                    self.showToastAlert(message: "서버 점검중 입니다. 다음에 시도해 주세요", completion: {})
                    
                }
            }
        }
    }
}
