import UIKit
import RxSwift
import RxCocoa

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
        input()
        output()
        buttonRxTap()
    }
}


extension AuthViewController {

    func input() {
        selfView.textFiled.rx.text.orEmpty
            .map(viewModel.applyHyphen)
            .bind(to: viewModel.textFieldTextObserverable)
            .disposed(by: disposeBag)
        
        viewModel.textFieldTextObserverable
            .map(viewModel.validHandler) // bool
            .bind(to: viewModel.validation)
            .disposed(by: disposeBag)
        
    }
    
    func output() {
        
        viewModel.textFieldTextObserverable
            .bind(onNext: { text in
                self.selfView.textFiled.text = text
            })
            .disposed(by: disposeBag)
        
        viewModel.validation
            .bind(onNext: { b in
                if b {
                    self.selfView.button.backgroundColor = SeSacColor.green
                } else {
                    self.selfView.button.backgroundColor = SeSacColor.gray3
                }
            })
            .disposed(by: disposeBag)
    }
    
    func buttonRxTap() {
        self.selfView.button.rx.tap
            .bind(onNext: { b in
                if self.viewModel.validation.value {
                    // firebase 번호 보내기
                        // 1. 성공 --> 화면 이동
                        // 2. 많은 요청 --> 알럿
                        // 3. 에러 --> 알럿
                    self.showToast(message: "인증 되었습니다")
                } else {
                    // 전화 번호 패턴 아닐때 --> 알럿
                }
            })
            .disposed(by: disposeBag)
    }

}

extension AuthViewController {

}
