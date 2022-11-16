import UIKit
import RxSwift
import RxCocoa




class OnBoardingViewController: BaseViewController {
    
    let selfView = OnBoardingView()
    override func loadView() {
        view = selfView
    }
    
    let viewModel = OnboardingViewModel()
    let disposeBag = DisposeBag()
    
    lazy var dataSoruce = OnBoardingDataSource(collectionView: selfView.collectionView)
    
    deinit {
        print("deinit - OnBoardingViewController")
    }
}


extension OnBoardingViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        selfView.eventDelegate = self
        dataSoruce.applySnapshot()
        bind()
    }
}

extension OnBoardingViewController {
    func bind() {
        selfView.button.rx.tap
            .bind(onNext: { _ in
                
                UserDefaultsManager.standard.onboardFlag = true
                
                print("🟩",UserDefaultsManager.standard.onboardFlag)
                
                let vc = AuthViewController()
                self.transitionRootViewController(vc, transitionStyle: .presentNavigation)

            })
            .disposed(by: disposeBag)
        
    }
}

extension OnBoardingViewController: OnBoardingViewEvent {
    func page(_ view: OnBoardingView, pageIndex: Int) {
        viewModel.pageIndex.onNext(pageIndex)
    }
}
