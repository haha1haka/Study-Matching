import UIKit
import RxSwift
import RxCocoa

class GenderViewController: BaseViewController {
    let selfView = GenderView()
    override func loadView() {
        view = selfView
    }
    
    let viewModel = GenderViewModel()
    
    let disposeBag = DisposeBag()
    
    var collectionViewDataSource: UICollectionViewDiffableDataSource<String, String>!
}

extension GenderViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        selfView.collectionView.delegate = self
        configureCollectionViewDataSource()
        applySnapshot()
        
        bind()
    }
}




extension GenderViewController {
    
    func bind() {
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
                    let api = MemoleaseRouter.signup(phoneNumber: UserDefaultsManager.standard.phoneNumber,
                                                     FCMToken: UserDefaultsManager.standard.FCMToken,
                                                     nick: UserDefaultsManager.standard.nick,
                                                     birth: UserDefaultsManager.standard.birth,
                                                     email: UserDefaultsManager.standard.email,
                                                     gender: UserDefaultsManager.standard.gender)
                    
                    print(UserDefaultsManager.standard.phoneNumber)
                    print(UserDefaultsManager.standard.FCMToken)
                    print(UserDefaultsManager.standard.nick)
                    print(UserDefaultsManager.standard.birth)
                    print(UserDefaultsManager.standard.email)
                    print(UserDefaultsManager.standard.gender)
                    
//                    MemoleaseService.shared.requestSignup(path: api.path, queryItems: api.queryItems, httpMethod: api.httpMethod, headers: api.headers) { result in
//                        switch result {
//                        case .success:
//                            print("⚠️성공 --> 홈화면 이동 ")
//                        case .failure(let error):
//                            switch error {
//                            case .alreadyUser:
//                                print("⚠️이미 유저 있음 --> 홈화면 이동")
//                            case .nickError:
//                                print("⚠️닉네임 에러 --> 닉네임화면gogo 다시 설정 하게 돌아가야됨")
//                            case .firebaseTokenError:
//                                print("⚠️토큰 만료 --> 토큰 재갱신")
//                            case .serverError:
//                                print("서버에러")
//                            case .clientError:
//                                print("헤더와 바디 잘 확인 하기")
//                            case .unknown:
//                                print("알수 없는 유저임")
//                            }
//                        }
//                    }
                }
                                
                
            })
            .disposed(by: disposeBag)
    }

}




extension GenderViewController {
    
    func configureCollectionViewDataSource() {
        
        let CellRegistration = UICollectionView.CellRegistration<GenderCell,String> { cell, indexPath, itemIdentifier in
            switch indexPath.item {
            case .zero:
                cell.imageView.image = UIImage(named: "man")
            default:
                cell.imageView.image = UIImage(named: "woman")
            }
            
        }
        
        collectionViewDataSource = UICollectionViewDiffableDataSource<String, String>(collectionView: selfView.collectionView) {
            collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: CellRegistration, for: indexPath, item: itemIdentifier)
            return cell
        }
    }
    
    func applySnapshot() {
        var snapshot = collectionViewDataSource.snapshot()
        snapshot.appendSections(["첫번째"])
        snapshot.appendItems(["1", "2"])
        collectionViewDataSource.apply(snapshot)
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
