import UIKit



enum SceneType: String {
    case onboarding
    case auth
    case nick
    case home
}


class FakerViewController: BaseViewController {
    let selfView = FakerView()
    override func loadView() {
        view = selfView
    }
    deinit {
        print("FakerViewController - deinit")
    }
}

extension FakerViewController {
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        sleep(3)
        saveSceneType()
        coordinator()
        
    }
}
extension FakerViewController {
    func saveSceneType() {
        print("❌\(UserDefaultsManager.standard.onboardFlag)")
        
        if UserDefaultsManager.standard.onboardFlag == false {
            
            //온보딩 화면으로 고고
            
            print("❌\(UserDefaultsManager.standard.onboardFlag)")
            
            UserDefaultsManager.standard.sceneType = SceneType.onboarding.rawValue
            
        } else {
            if UserDefaultsManager.standard.idToken == "" {
                // 로그인부터 -> 회원가입까지 쭉 진행
//                let vc = AuthViewController()
//                self.transition(vc, transitionStyle: .present)
                UserDefaultsManager.standard.sceneType = SceneType.auth.rawValue
                
            } else {
                //로그인 요청
                /*
                 성공 -> 홈화면
                 실패 -> 1. 미가입 2.서버에러, 3.클라에러(휴먼)
                 1일때 -> 닉네임 화면이동
                 2일때 -> 얼럿
                 3일때 -> 얼럿
                 */
                let api = MemoleaseRouter.signIn
                MemoleaseService.shared.requestSignIn(path: api.path, queryItems: nil, httpMethod: api.httpMethod, headers: api.headers) { result in
                    switch result {
                    case .success(let user):
                        
                        print("🥰\(user)")
                        
                    
//                        let vc = MainViewController()
//                        self.transition(vc, transitionStyle: .present)
                        UserDefaultsManager.standard.sceneType = SceneType.home.rawValue
                                                    
                    case .failure(let error):
                        
                        switch error {
                        case .firebaseTokenError:
                            print("FakerVC - 토큰 만료")
                            self.requestRefreshIdToken()
                            
                        case .unRegistedUser:
                            
                            print("FakerVC - 미가입 유저")
//                            let vc = NicknameViewController()
//                            self.transition(vc, transitionStyle: .present)
                            UserDefaultsManager.standard.sceneType = SceneType.nick.rawValue
                        case .serverError:
                            print("FakerVC - 서버에러")
                            
                        case .clientError:
                            print("FakerVC - 클라에러")
                            
                        default:
                            print("FakerVC - 모른는 에러")
                        }
                    }
                }
                
            }

        }
        
    }
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
            self.transition(vc, transitionStyle: .presentfull)

        case .home:
            let vc = MainViewController()
            self.transition(vc, transitionStyle: .presentfull)

        default:
            print("나도 몰라")

        }
    }

}

extension FakerViewController {
    func requestRefreshIdToken() {
        FirebaseService.shared.requestRefreshIdToken { result in
            switch result {
            case .success(.perfact):
                self.coordinator()
            case .failure(.refreshError):
                print("리프레시 하다가 발생한 에러")
            default:
                print("리프레쉬 그외 에러")
            }
        }
    }

}
