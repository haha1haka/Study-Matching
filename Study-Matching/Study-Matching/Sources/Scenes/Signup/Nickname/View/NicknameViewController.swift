import UIKit
import RxSwift
import RxCocoa

class NicknameViewController: BaseViewController {
    let selfView = NicknameView()
    override func loadView() {
        view = selfView
    }
    let viewModel = NickNameViewModel()
    let disposeBag = DisposeBag()
}

extension NicknameViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()

    }
}
extension NicknameViewController {
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
        


        self.selfView.button.rx.tap
            .bind(onNext: { _ in
                if self.viewModel.validationFlag.value {
                    //일단은 화면 전환
                    guard let nick = self.selfView.textFiled.text else { return }
                    
                    UserDefaultsManager.standard.nick = nick
                    
                    let vc = BirthViewController()
                    self.transition(vc, transitionStyle: .push)
                } else {
                    //그냥 두기 --> gender 에서 확인 할거니깐
                }
            })
            .disposed(by: disposeBag)
            
        
    }
}

extension NicknameViewController {

}
