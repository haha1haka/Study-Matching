import UIKit
import RxSwift
import RxCocoa



class SMSViewController: BaseViewController {
    let selfView   = SMSView()
    let viewModel  = SMSViewModel()
    let disposeBag = DisposeBag()
    override func loadView() { view = selfView }
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
        // MARK: -🟨 2.SMS확인 -> 3.fetchIdToken -> 4.로그인(가입 미가입 확인)
        selfView.button.rx.tap
            .bind(onNext: {
                if self.viewModel.validationFlag.value {

                    guard let smsCode = self.selfView.textFiled.text else { return }
                    
                    self.viewModel.vertifySMSCode(smsCode: smsCode) {
                        switch $0 {
                        case .success:
                            UserDefaultsManager.standard.smsFlag = true //⭐️ 전화번호 인증완료된후에는 시작 화면 Nick 으로 나오게 할려고
                            self.checkUser()
                        case .failure(let error):
                            switch error {
                            case .invalidVerificationCode:
                                self.showToast(message: "전화 번호 인증 실패")
                            case .tooManyRequest:
                                self.showToast(message: "전화 번호 인증 실패")
                            default:
                                return
                            }
                        }
                    }
                } else {
                    self.showToast(message: "인증번호 숫자만 6자리로 입력 해달라구요!")
                }
            })
            .disposed(by: disposeBag)
        
    }
    
}



extension SMSViewController {
    func checkUser() {
        self.viewModel.requestUserInfo {
            switch $0 {
            case .success:
                    let vc = TabBarController()
                    self.transitionRootViewController(vc)
            case .failure(let error):
                switch error {
                case .unRegistedUser:
                    print("ㅇㄹㄴㄹㄴㅇ")
                    let vc = NicknameViewController()
                    self.transition(vc)
                case .idTokenError:
                    print("이거이거이거이거이거이거이거")
                    self.checkUser()
                default:
                    return
                }
            }
        }
    }
}
