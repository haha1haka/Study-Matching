import UIKit
import RxSwift
import RxCocoa

class EmailViewController: BaseViewController {
    let selfView = EmailView()
    override func loadView() {
        view = selfView
    }
    let viewModel = EmailViewModel()
    let disposeBag = DisposeBag()
}

extension EmailViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()

    }
}
extension EmailViewController {
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
        
        

        selfView.button.rx.tap
            .bind(onNext: { _ in
                if self.viewModel.validationFlag.value {
                    
                    guard let email = self.selfView.textFiled.text else { return }
                    UserDefaultsManager.standard.email = email
                    
                    
                    let vc = GenderViewController()
                    self.transition(vc,transitionStyle: .push)
                    
                } else {
                    self.showToast(message: "이메일 형식이 맞지 않습니다.")
                }
            })
            .disposed(by: disposeBag)
    }

}

extension EmailViewController {

}

