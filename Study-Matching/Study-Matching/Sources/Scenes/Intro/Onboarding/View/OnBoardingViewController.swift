import UIKit
import RxSwift
import RxCocoa


class OnBoardingViewController: BaseViewController, DataSourceRegistration {
    
    let selfView = OnBoardingView()
    
    override func loadView() { view = selfView }

    var cell: OnBoardingCellRegistration?
    var footer: OnBoardingFooterRegistration?
    
    lazy var dataSoruce = OnBoardingDataSource(
            collectionView:     selfView.collectionView,
            cellRegistration:   self.cell!,
            footerRegistration: self.footer!)
    
    let viewModel = OnboardingViewModel()
    let disposeBag = DisposeBag()
    
    deinit {
        print("deinit - OnBoardingViewController")
    }

}


extension OnBoardingViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        selfView.eventDelegate = self
        bind()
        dataSoruce.applySnapshot()
    }
}

extension OnBoardingViewController {
    
    func bind() {
        
        cell = OnBoardingCellRegistration { cell, indexPath, itemIdentifier in
            cell.configure(with: itemIdentifier)
        }
        
        footer = OnBoardingFooterRegistration(elementKind: UICollectionView.elementKindSectionFooter)
        { [weak self] supplementaryView, elementKind, indexPath in
            
            guard let self = self else { return }
            
            let itemCount = self.dataSoruce.snapshot().numberOfItems
            
            supplementaryView.configure(with: itemCount)
            
            self.viewModel.pageIndex.bind(onNext: { int in
                supplementaryView.pageControl.currentPage = int
            })
            .disposed(by: self.disposeBag)
        
        }

    
        selfView.button.rx.tap
            .bind(onNext: { _ in
                
                UserDefaultsManager.standard.onboardFlag = true
                
                print("🟩",UserDefaultsManager.standard.onboardFlag)
                
                let vc = AuthViewController()
                self.transitionRootViewController(vc, transitionStyle: .toRootWithNavi)

            })
            .disposed(by: disposeBag)
    }
}

extension OnBoardingViewController: OnBoardingViewEvent {
    func page(_ view: OnBoardingView, pageIndex: Int) {
        viewModel.pageIndex.onNext(pageIndex)
    }
}


