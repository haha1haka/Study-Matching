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
            .map(viewModel.applydividerView)
            .bind(to: viewModel.dividerViewFlag)
            .disposed(by: disposeBag)
        
        viewModel.textFieldTextObserverable
            .map(viewModel.validHandler)
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
            .bind(onNext: {
                if self.viewModel.validationFlag.value {
                    guard let smsCode = self.selfView.textFiled.text else { return }
                    self.viewModel.vertifySMSCode(smsCode: smsCode) {
                        switch $0 {
                        case .success:
                            UserDefaultsManager.standard.smsFlag = true
                            
                            FirebaseService.shared.fetchIdToken { _ in
                                self.checkUser()
                            }
                            return
                        case .failure(let error):
                            switch error {
                            case .invalidVerificationCode:
                                self.showToastAlert(message: "전화 번호 인증 실패", completion: {})
                                return
                            case .tooManyRequest:
                                self.showToastAlert(message: "전화 번호 인증 실패", completion: {})
                                return
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
                self.transitionRootViewController(vc, transitionStyle: .toRoot)
            case .failure(let error):
                switch error {
                case .unRegistedUser:
                    let vc = NicknameViewController()
                    self.transition(vc)
                case .idTokenError:
                    self.checkUser()
                default:
                    return
                }
            }
        }
    }
}
