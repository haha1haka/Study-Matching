import UIKit
import RxSwift
import RxCocoa

class GenderViewController: BaseViewController {
    let selfView = GenderView()
    override func loadView() {
        view = selfView
    }
    
    let viewModel = GenderViewModel()
    let disposeBag = DisposeBag()
    
    lazy var dataSource = GenderDataSource(collectionView: selfView.collectionView)
}

extension GenderViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        selfView.collectionView.delegate = self
        dataSource.applySnapshot()
        bind()
    }
}




extension GenderViewController {
    
    func bind() {
        viewModel.collectionViewObservable
            .bind(onNext: { b in
                if b == 1 { //남자: 1
                    UserDefaultsManager.standard.gender = b
                    self.selfView.button.backgroundColor = SeSacColor.green
                } else if b == 0 {
                    UserDefaultsManager.standard.gender = b
                    self.selfView.button.backgroundColor = SeSacColor.green
                } else {
                    self.selfView.button.backgroundColor = SeSacColor.gray3
                }
                
            })
            .disposed(by: disposeBag)
        
        
        
        
        
        selfView.button.rx.tap
            .bind(onNext: { _ in
                if self.viewModel.collectionViewObservable.value != -1 {
                    let api = MemoleaseRouter.signup(phoneNumber: UserDefaultsManager.standard.phoneNumber,
                                                     FCMToken: UserDefaultsManager.standard.FCMToken,
                                                     nick: UserDefaultsManager.standard.nick,
                                                     birth: UserDefaultsManager.standard.birth,
                                                     email: UserDefaultsManager.standard.email,
                                                     gender: UserDefaultsManager.standard.gender)
                    
                    print(UserDefaultsManager.standard.phoneNumber)
                    print(UserDefaultsManager.standard.FCMToken)
                    print(UserDefaultsManager.standard.nick)
                    print(UserDefaultsManager.standard.birth)
                    print(UserDefaultsManager.standard.email)
                    print(UserDefaultsManager.standard.gender)
                    print(UserDefaultsManager.standard.idToken)
                    
                    MemoleaseService.shared.requestSignup(path: api.path, queryItems: api.queryItems, httpMethod: api.httpMethod, headers: api.headers) { result in
                        switch result {
                        case .success:
                            print("⚠️성공 --> 홈화면 이동 ")
                            let vc = MainViewController()
                            self.transitionRootViewController(vc)
                        case .failure(let error):
                            switch error {
                            case .alreadyUser:
                                print("⚠️이미 유저 있음 --> 홈화면 이동")
                                let vc = MainViewController()
                                self.transitionRootViewController(vc)
                            case .nickError:
                                print("⚠️닉네임 에러 --> 닉네임화면gogo 다시 설정 하게 돌아가야됨")
                                self.toNickNameViewController()
                                UserDefaultsManager.standard.nickFlag = true
                            case .firebaseTokenError:
                                print("⚠️토큰 만료 --> 토큰 재갱신")
                                self.fetchIdToken() // ⭐️토큰 다시 받기 + if succeess면 로그인 재도전    (무한 츠크요미 조심 )
                                
                            case .serverError:
                                print("서버에러")
                            case .clientError:
                                print("헤더와 바디 잘 확인 하기")
                            default:
                                print("알수 없는 유저임")
                            }
                        }
                    }
                }
                
                
            })
            .disposed(by: disposeBag)
    }
    
}
extension GenderViewController {
    func reReauestMemoleaseSignup() {
        let api = MemoleaseRouter.signup(phoneNumber: UserDefaultsManager.standard.phoneNumber,
                                         FCMToken: UserDefaultsManager.standard.FCMToken,
                                         nick: UserDefaultsManager.standard.nick,
                                         birth: UserDefaultsManager.standard.birth,
                                         email: UserDefaultsManager.standard.email,
                                         gender: UserDefaultsManager.standard.gender)

        MemoleaseService.shared.requestSignup(path: api.path, queryItems: api.queryItems, httpMethod: api.httpMethod, headers: api.headers) { result in
            switch result {
            case .success:
                print("⚠️성공 --> 홈화면 이동 ")
                let vc = MainViewController()
                self.transitionRootViewController(vc)
            case .failure(let error):
                switch error {
                case .alreadyUser: //201
                    print("⚠️이미 유저 있음 --> 홈화면 이동")
                    let vc = MainViewController()
                    self.transitionRootViewController(vc)
                case .nickError:
                    print("⚠️닉네임 에러 --> 닉네임화면gogo 다시 설정 하게 돌아가야됨")
                    self.toNickNameViewController()
                    UserDefaultsManager.standard.nickFlag = true
                case .firebaseTokenError:
                    print("⚠️토큰 만료 --> 토큰 재갱신")
                    self.fetchIdToken() // ⭐️토큰 다시 받기 + if succeess면 로그인 재도전    (무한 츠크요미 조심 )
                case .serverError:
                    print("서버에러")
                case .clientError:
                    print("헤더와 바디 잘 확인 하기")
                default:
                    print("알수 없는 유저임")
                }
            }
        }
    }
}






extension GenderViewController {
    func fetchIdToken() {
        FirebaseService.shared.fetchIdToken { reuslt in
            switch reuslt {
            case .success(.perfact):
                self.reReauestMemoleaseSignup() //⭐️ 다시 로그인 도전
            case .failure(let error):
                switch error {
                case .refreshError:
                    self.showToast(message: "ID토큰오류: 에러가 발생했습니다. 잠시 후 다시 시도해주세요")
                default:
                    self.showToast(message: "알수없는 토큰 업데이트 에러")
                }
            }
        }
    }

}

extension GenderViewController {
    func toNickNameViewController() {
        guard let presentingVC = self.presentingViewController as? UINavigationController else { return }
        let viewControllerStack = presentingVC.viewControllers
        print("✅ viewControllerStack: \(viewControllerStack)")
        self.dismiss(animated: true) {
            for viewController in viewControllerStack {
                if let nickVC = viewController as? NicknameViewController {
                    print("✅ rootVC: \(nickVC)")
                    presentingVC.popToViewController(nickVC, animated: true)
                }
            }
        }
    }
}



extension GenderViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if indexPath.item == 1 {
            viewModel.collectionViewObservable.accept(0)
        } else {
            viewModel.collectionViewObservable.accept(1)
        }
        
    }
}
