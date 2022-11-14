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
        
        
        selfView.button.rx.tap
            .bind(onNext: { _ in
                if self.viewModel.validationFlag.value { //최소조건 : 6자리 -- true 면, 로그인 시작 --> success, error 처리 어디서?
                    print(" 파베에 vertification 과 함게 로그인 로직 타겠끔 해주자 --> 파베 service 안에서 에러 처리 하는게 맞는거 같다 그래서 true 면 화면 전환 고고 ")
                    guard let smsCode = self.selfView.textFiled.text else { return }
                    
                    FirebaseService.shared.requestSignIn(smsCode: smsCode) { b in
                        
                        switch b {
                        case .success:
                            
                            self.requestRefreshIdToken()
                            
                            let vc = NicknameViewController()
                            self.transition(vc, transitionStyle: .push)
                            
                        case .failure(let error):
                            switch error {
                            case .invalidVerificationCode:
                                print("인증번호 불일치")
                            case .tooManyRequest:
                                print("너무 잦은 요철")
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
    func requestRefreshIdToken() {
        FirebaseService.shared.requestRefreshIdToken { result in
            switch result {
            case .success(.perfact):
                print()
            case .failure(.refreshError):
                print("리프레시 하다가 발생한 에러")
            default:
                print("리프레쉬 그외 에러")
            }
        }
    }
}
extension SMSViewController {
    func requestSignIn() {
        let api = MemoleaseRouter.signIn
        MemoleaseService.shared.requestSignIn(path: api.path, queryItems: api.queryItems, httpMethod: api.httpMethod, headers: api.headers) { result in
            switch result {
            case .success:
                print("로그인성공")
                
            case .failure(let error):
                switch error {
                case .firebaseTokenError:
                    print("signIn - 토큰에러")
                case .unRegistedUser:
                    print("signIn - 등록된 사용자 없데")
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
