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
    
    /*
     flag 그 젤 마지막에 심어 줬다가 닉네임 오류 메세지 넘어 왔을때
     뷰컨 돌려,
     그다음 그 flag 일치하면 로직 다겠끔
     flag 해주는 이유:
     */
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
                    self.showToast(message: "닉네임은 1자 이상 10자 이내로 부탁드려요")
                }
            })
            .disposed(by: disposeBag)
            
        
    }
}

extension NicknameViewController {

}
