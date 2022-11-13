import UIKit
import RxSwift
import RxCocoa

enum AuthStatus: Error {
    case succcess
    case overAuth
    case error
}




class AuthViewController: BaseViewController {
    let selfView = AuthView()
    override func loadView() {
        view = selfView
    }
    let viewModel = AuthViewModel()
    let disposeBag = DisposeBag()
}

extension AuthViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
}


extension AuthViewController {

    func bind() {
        selfView.textFiled.rx.text.orEmpty
            .map(viewModel.applyHyphen)
            .bind(to: viewModel.textFieldTextObserverable)
            .disposed(by: disposeBag)
        
        selfView.textFiled.rx.text.orEmpty
            .map(viewModel.applydividerView)
            .bind(to: viewModel.dividerViewFlag)
            .disposed(by: disposeBag)
        
        viewModel.textFieldTextObserverable
            .map(viewModel.validHandler) // bool
            .bind(to: viewModel.validationFlag)
            .disposed(by: disposeBag)
        
    
    
    
        
        viewModel.textFieldTextObserverable
            .bind(onNext: { text in
                self.selfView.textFiled.text = text
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
        
        viewModel.validationFlag
            .bind(onNext: { b in
                if b {
                    self.selfView.button.backgroundColor = SeSacColor.green
                } else {
                    self.selfView.button.backgroundColor = SeSacColor.gray3
                }
            })
            .disposed(by: disposeBag)
    
    
    
        self.selfView.button.rx.tap
            .bind(onNext: { _ in
                if self.viewModel.validationFlag.value {
                    
                    // firebase 번호 보내기
                        // 1. 성공 --> 화면 이동
                    guard let phoneNumber = self.selfView.textFiled.text else { return }
                    FirebaseService.shared.startAuth(phoneNumber: "+1\(phoneNumber)") { b in
                        
                        if b {
                            print("인증 확인 true면 --> 화면 전환")
                            let vc = SMSViewController()
                            self.transition(vc, transitionStyle: .push)
                        } else {
                            print("가상번호 없음")
                        }
                    }
                        // 2. 많은 요청 --> 알럿
                    //self.showToast(message: "너무 많은 요청이요~")
                        // 3. 에러 --> 알럿
                    //self.showToast(message: "인증 되었습니다")
                } else {
                    // 전화 번호 패턴 아닐때 --> 알럿
                    self.showToast(message: "전화 번호 패턴을 확인해 주세요")
                }
            })
            .disposed(by: disposeBag)
    }

}

extension AuthViewController {

}
