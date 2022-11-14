import UIKit
import RxSwift
import RxCocoa

class SMSViewController: BaseViewController {
    let selfView = SMSView()
    override func loadView() {
        view = selfView
    }
    let viewModel = SMSViewModel()
    let disposeBag = DisposeBag()
}

extension SMSViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
}
extension SMSViewController {
    func bind() {
        selfView.textFiled.rx.text.orEmpty
            .bind(to: viewModel.textFieldTextObserverable)
            .disposed(by: disposeBag)
        
        selfView.textFiled.rx.text.orEmpty
            .map(viewModel.applydividerView) // true
            .bind(to: viewModel.dividerViewFlag)
            .disposed(by: disposeBag)
        
        
        
        viewModel.textFieldTextObserverable
            .map(viewModel.validHandler) // bool
            .bind(to: viewModel.validationFlag)
            .disposed(by: disposeBag)
        
        
        
        
        viewModel.validationFlag
            .bind(onNext: { b in
                if b {
                    self.selfView.button.backgroundColor = SeSacColor.green
                } else {
                    self.selfView.button.backgroundColor = SeSacColor.gray3
                }
            })
            .disposed(by: disposeBag)
        
        
        viewModel.dividerViewFlag
            .bind(onNext: { b in
                if b {
                    self.selfView.textFiled.dividerView.backgroundColor = SeSacColor.gray3
                    
                } else {
                    self.selfView.textFiled.dividerView.backgroundColor = SeSacColor.black
                }
            })
            .disposed(by: disposeBag)
        
        
        //🥶 토큰 받았는데도 에러 나면 다시 보내야 되는 경우 토의 해보기
        
        selfView.button.rx.tap
            .bind(onNext: { _ in
                if self.viewModel.validationFlag.value {
                    print(" 파베에 vertification 과 함게 로그인 로직 타겠끔 해주자 --> 파베 service 안에서 에러 처리 하는게 맞는거 같다 그래서 true 면 화면 전환 고고 ")
                    guard let smsCode = self.selfView.textFiled.text else { return }
                    
                    
                    //통신 3개 일어 나는 곳
                    // sms코드 일치 여부 확인
                    // 성공 : idToken 깔고 잘 깔리면 내가 가입 했었는지 확인
                        //이미 가입했었으면, 홈
                        //미 가입 유저면, nickVC
                    FirebaseService.shared.vertifySMSCode(smsCode: smsCode) { result in

                        switch result {
                        case .success:
                            UserDefaultsManager.standard.smsFlag = true //⭐️ 전화번호 인증완료된후에는 시작 화면 Nick 으로 나오게 할려고
                            FirebaseService.shared.fetchIdToken { reuslt in
                                switch reuslt {
                                case .success(.perfact):
                                    self.requestUserInfo() //🚨
                                case .failure(let error):
                                    switch error {
                                    case .refreshError:
                                        self.showToast(message: "ID토큰오류: 에러가 발생했습니다. 잠시 후 다시 시도해주세요")
                                    default:
                                        self.showToast(message: "알수없는 토큰 업데이트 에러")
                                    }
                                }
                            }

                        case .failure(let error):
                            switch error {
                            case .invalidVerificationCode:
                                self.showToast(message: "인증번호불일치: 전화번호 인증 실패")
                            case .tooManyRequest:
                                print("너무 잦은 요청")
                            default:
                                print("그외 모든 에러 --> \(error.localizedDescription)")
                            }
                        }
                    }
                }
                else {
                    self.showToast(message: "인증번호 숫자만 6자리로 입력 해달라구요!")
                }
            })
            .disposed(by: disposeBag)
        
    }
    
}



extension SMSViewController {
    func requestUserInfo() {
        let api = MemoleaseRouter.signIn
        MemoleaseService.shared.requestUserInfo(path: api.path, queryItems: api.queryItems, httpMethod: api.httpMethod, headers: api.headers) { result in
            switch result {
            case .success:
                print("로그인성공")
                
                let vc = MainViewController()
                self.transitionRootViewController(vc)
            case .failure(let error):
                switch error {
                case .firebaseTokenError:
                    print("signIn - 토큰에러")
                case .unRegistedUser:
                    print("signIn - 406 미가입 유저 --> 닉네임 화면부터다시")
                    let vc = NicknameViewController()
                    self.transition(vc)
                case .serverError:
                    print("signIn - 서버에러")
                case .clientError:
                    print("signIn - 내 휴먼 에러일 가능성 높아 바디 확인")
                default:
                    print("signIn - 아직 알 수 없음")
                }
            }
        }
    }
}
