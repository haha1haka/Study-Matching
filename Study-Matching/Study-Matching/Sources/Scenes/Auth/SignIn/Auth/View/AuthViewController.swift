import UIKit
import RxSwift
import RxCocoa

class AuthViewController: BaseViewController {
    
    let selfView   = AuthView()
    let viewModel  = AuthViewModel()
    let disposeBag = DisposeBag()
    
    override func loadView() { view = selfView }
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
                    guard let phoneNumber = self.selfView.textFiled.text?.toPureNumber else { return }
                    UserDefaultsManager.standard.phoneNumber = phoneNumber
                    self.viewModel.requestVertificationID(phoneNumber: phoneNumber) {
                        switch $0 {
                        case .success:
                            let vc = SMSViewController()
                            self.transition(vc, transitionStyle: .push)
                        case .failure(let error):
                            switch error {
                            case .tooManyRequest :
                                self.showToastAlert(message: "????????? ?????? ????????? ???????????????. ????????? ?????? ????????? ?????????.", completion: {})
                            default:
                                self.showToastAlert(message: "????????? ?????????????????? ?????? ??????????????????", completion: {})
                                
                            }
                        }
                    }
                    
                }
                else {
                    self.showToast(message: "????????? ???????????? ???????????????.")
                }
            })
            .disposed(by: disposeBag)
    }
    
}
