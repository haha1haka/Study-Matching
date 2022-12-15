import UIKit
import RxSwift
import RxCocoa

class GenderViewController: BaseViewController, DataSourceRegistration {
    
    let selfView = GenderView()
    override func loadView() {
        view = selfView
    }
    
    var cell: GenderCellRegistration?
    
    lazy var dataSource = GenderDataSource(
        collectionView: selfView.collectionView,
        cellRegistration: self.cell!)
    
    let viewModel = GenderViewModel()
    let disposeBag = DisposeBag()
}

extension GenderViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        dataSource.applySnapshot()
        selfView.collectionView.delegate = self
    }
}




extension GenderViewController {
    
    func bind() {
        
        cell = GenderCellRegistration
        { cell, indexPath, itemIdentifier in
            cell.configure(with: itemIdentifier)
        }
        
        
        viewModel.collectionViewObservable
            .bind(onNext: { b in
                if b == 1 { //남자: 1
                    UserDefaultsManager.standard.gender = b
                    self.selfView.button.backgroundColor = SeSacColor.green
                } else if b == 0 {
                    UserDefaultsManager.standard.gender = b
                    self.selfView.button.backgroundColor = SeSacColor.green
                } else {
                    self.selfView.button.backgroundColor = SeSacColor.gray3
                }
                
            })
            .disposed(by: disposeBag)
        
        
        
        
        
        selfView.button.rx.tap
            .bind(onNext: { _ in
                if self.viewModel.collectionViewObservable.value != -1 {
                    
                    print(UserDefaultsManager.standard.phoneNumber)
                    print(UserDefaultsManager.standard.FCMToken)
                    print(UserDefaultsManager.standard.nick)
                    print(UserDefaultsManager.standard.birth)
                    print(UserDefaultsManager.standard.email)
                    print(UserDefaultsManager.standard.gender)
                    print(UserDefaultsManager.standard.idToken)
                    
                    
                    self.viewModel.requestSignup {
                        switch $0 {
                        case .success:
                            let vc = TabBarController()
                            self.transitionRootViewController(vc, transitionStyle: .toRoot)
                            UserDefaultsManager.standard.smsFlag = false
                        case .failure(let error):
                            switch error {
                            case .alreadyUser:
                                let vc = TabBarController()
                                self.transitionRootViewController(vc, transitionStyle: .toRoot)
                            case .nickError:
                                self.toNickNameViewController()
                                UserDefaultsManager.standard.nickFlag = true    
                            default:
                                return
                                
                            }
                        }
                    }
                }
            })
            .disposed(by: disposeBag)
    }
}

extension GenderViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if indexPath.item == 1 {
            viewModel.collectionViewObservable.accept(0)
        } else {
            viewModel.collectionViewObservable.accept(1)
        }
        
    }
}


extension GenderViewController {
    func toNickNameViewController() {
        guard let presentingVC = self.presentingViewController as? UINavigationController else { return }
        let viewControllerStack = presentingVC.viewControllers
        print("✅ viewControllerStack: \(viewControllerStack)")
        self.dismiss(animated: true) {
            for viewController in viewControllerStack {
                if let nickVC = viewController as? NicknameViewController {
                    print("✅ rootVC: \(nickVC)")
                    presentingVC.popToViewController(nickVC, animated: true)
                }
            }
        }
    }
}
