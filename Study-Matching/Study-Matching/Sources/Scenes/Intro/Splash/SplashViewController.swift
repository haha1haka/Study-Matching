import UIKit



enum SceneType: String {
    case onboarding
    case auth
    case nick
    case map
}


class SplashViewController: BaseViewController {
    let selfView = SplashView()
    override func loadView() {
        view = selfView
    }
    deinit {
        print("FakerViewController - deinit")
    }
}

extension SplashViewController {
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if UserDefaultsManager.standard.smsFlag == false {
            sleep(3)
            //saveSceneType()
            coordinator()
            
        } else {
            UserDefaultsManager.standard.smsFlag = false
            let vc = NicknameViewController()
            self.transitionRootViewController(vc)
        }
        
        
                
    }
}
extension SplashViewController {
//    func saveSceneType() {
//        print("❌\(UserDefaultsManager.standard.onboardFlag)")
//
//        if UserDefaultsManager.standard.onboardFlag == false {
//
//            print("❌\(UserDefaultsManager.standard.onboardFlag)")
//
//            UserDefaultsManager.standard.sceneType = SceneType.onboarding.rawValue
//
//        } else {
//            if UserDefaultsManager.standard.idToken == "" {
//
//                UserDefaultsManager.standard.sceneType = SceneType.auth.rawValue
//
//            } else {
//                //로그인 요청
//                /*
//                 성공 -> 홈화면
//                 실패 -> 1. 미가입 2.서버에러, 3.클라에러(휴먼)
//                 1일때 -> 닉네임 화면이동
//                 2일때 -> 얼럿
//                 3일때 -> 얼럿
//                 */
//                let api = MemoleaseRouter.signIn
//                MemoleaseService.shared.requestLogin(path: api.path, queryItems: nil, httpMethod: api.httpMethod, headers: api.headers) { result in
//                    switch result {
//                    case .success(let user):
//                        print("🥰\(user)")
//                        UserDefaultsManager.standard.sceneType = SceneType.home.rawValue
//
//                    case .failure(let error):
//
//                        switch error {
//                        case .idTokenError:
//                            print("FakerVC - 토큰 만료")
//                            self.requestRefreshIdToken() //재발급 + 다시 유저 요청
//                        case .unRegistedUser:
//                            print("FakerVC - 미가입 유저")
//                            UserDefaultsManager.standard.sceneType = SceneType.nick.rawValue
//                        case .serverError:
//                            print("FakerVC - 서버에러")
//
//                        case .clientError:
//                            print("FakerVC - 클라에러")
//
//                        default:
//                            print("FakerVC - 모른는 에러")
//                        }
//                    }
//                }
//
//            }
//
//        }
//
//    }
    func coordinator() {
        let sceneType = UserDefaultsManager.standard.sceneType
        let firstScene = SceneType(rawValue: sceneType)
        print("✨\(sceneType)")
        switch firstScene {
        case .onboarding:
            let vc = OnBoardingViewController()
            self.transitionRootViewController(vc, transitionStyle: .presentNavigation)
        case .auth:
            let vc = AuthViewController()
            self.transitionRootViewController(vc, transitionStyle: .presentNavigation)

        case .nick:
            let vc = NicknameViewController()
            self.transitionRootViewController(vc, transitionStyle: .presentNavigation)

        case .map:
            let vc = MapViewController()
            self.transitionRootViewController(vc, transitionStyle: .presentNavigation)

        default:
            print("나도 몰라")

        }
    }

}

extension SplashViewController {
    func requestRefreshIdToken() {
        FirebaseService.shared.fetchIdToken { result in
            switch result {
            case .success(.perfact):
                self.coordinator()
            case .failure(.idTokenFetchError):
                print("리프레시 하다가 발생한 에러")
            default:
                print("리프레쉬 그외 에러")
            }
        }
    }

}
