import UIKit
import RxSwift
import RxCocoa

class BirthViewController: BaseViewController {
    let selfView = BirthView()
    override func loadView() {
        view = selfView
    }
    let viewModel = BirthViewModel()
    let disposeBag = DisposeBag()
}

extension BirthViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        input()
        output()
        buttonRxTap()
        
    }
}
extension BirthViewController {
    func input() {
        selfView.datePicker.rx.date
            .bind(to: viewModel.datePickerObservable)
            .disposed(by: disposeBag)
        
        viewModel.datePickerObservable
            .map(viewModel.validHandler) // bool
            .bind(to: viewModel.validationFlag)
            .disposed(by: disposeBag)
        }

    
    func output() {
        
        viewModel.datePickerObservable
            .bind(onNext: { d in
                self.selfView.yearDateLabel.text = String(d.year)
                self.selfView.monthDateLabel.text = String(d.month)
                self.selfView.dayDateLabel.text = String(d.day)
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
        
        
    }
    func buttonRxTap() {
        self.selfView.button.rx.tap
            .bind(onNext: { _ in
                if self.viewModel.validationFlag.value {
                    print("17세 이상임")
                    let vc = EmailViewController()
                    self.transition(vc, transitionStyle: .push)
                } else {
                    self.showToast(message: "17세 이상 가입이 가능 합니다")
                }
            })
            .disposed(by: disposeBag)
        
        
    }

}

extension BirthViewController {

}

