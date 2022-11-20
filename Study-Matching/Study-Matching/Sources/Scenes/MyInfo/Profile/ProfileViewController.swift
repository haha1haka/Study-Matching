import UIKit
import RxSwift
import RxCocoa
import MultiSlider



class ProfileViewController: BaseViewController, DataSourceRegistration {
    
    let selfView = ProfileView()
    var header: ProfileHeaderRegistration?
    var mainCell: ProfileMainCellRegistration?
    var subCell: ProfileSubCellRegistration?
    
    
    lazy var dataSource = ProfileDataSource(
        collectionView      : selfView.collectionView,
        headerRegistration  : self.header!,
        mainCellRegistration: self.mainCell!,
        subCellRegistration : self.subCell!)
        
    let viewModel = MyInfoViewModel.shared
    let disposeBag = DisposeBag()
    
    override func loadView() {
        view = selfView
    }
    
    override func setNavigationBar(title: String) {
        super.setNavigationBar(title: "내정보")
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "저장", style: .plain, target: self, action: nil)
    }

    
}

extension ProfileViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        dataSource.applySnapshot()
        selfView.collectionView.delegate = self
    }
}




extension ProfileViewController {
    
    func bind() {
        
        self.navigationItem.rightBarButtonItem?.rx.tap
            .bind(onNext: { [weak self]_ in
                guard let self = self else { return }
                self.viewModel.updateUserInfo { result in
                    switch result {
                    case .success:
                        print("성공적으로 userinfo 가 update 되었습니다.")
                    case .failure:
                        print("에러")
                    
                    }
                }
            })
            .disposed(by: disposeBag)
        
        header = ProfileHeaderRegistration (elementKind: UICollectionView.elementKindSectionHeader)
        { [weak self] supplementaryView, elementKind, indexPath in
            guard let self = self else { return }
            
            self.viewModel.background
                .bind(onNext: { int in
                    if int == 0 {
                        supplementaryView.mainImageView.image = SeSacImage.sesacBg01
                    }
                })
                .disposed(by: self.disposeBag)
            
            self.viewModel.sesac
                .bind(onNext: { int in
                    if int == 0 {
                        supplementaryView.subImageView.image = SeSacImage.sesacFace2
                    }
                })
                .disposed(by: self.disposeBag)

        }
        
        mainCell = ProfileMainCellRegistration
        { [weak self] cell, indexPath, itemIdentifier in
            guard let self = self else { return }
    
            // MARK: - 김새싹
            self.viewModel.nick
                .bind(to: cell.nameLabel.rx.text)
                .disposed(by: self.disposeBag)
            

            // MARK: - 버튼 6개
            self.viewModel.reputation
                .bind(onNext: { arr in
                    [cell.cardStackView.button0,
                     cell.cardStackView.button1,
                     cell.cardStackView.button2,
                     cell.cardStackView.button3,
                     cell.cardStackView.button4,
                     cell.cardStackView.button5]
                    .forEach {
                        if !(arr[$0.tag] == 0) {
                            $0.toAct
                        }
                    }
            })
                .disposed(by: self.disposeBag)
            // MARK: - 리뷰
            
            self.viewModel.comment
                .bind(onNext: {
                    if $0.isEmpty {
                        cell.textField.placeholder = "첫 리뷰를 기다리는 중이에요~!"
                    } else {
                        cell.textField.text = $0.first ?? ""
                    }
                })
                .disposed(by: self.disposeBag)
        }
        
        subCell = ProfileSubCellRegistration
        { [weak self] cell, indexPath, itemIdentifier in
            guard let self = self else { return }
            cell.ageView.delegate = self
//             MARK: - 성별
            //인풋
            self.viewModel.gender
                .bind(onNext: { int in
                    if int == 1 {
                        cell.genderView.manButton.toAct
                        cell.genderView.womanButton.toInAct
                    } else {
                        cell.genderView.manButton.toInAct
                        cell.genderView.womanButton.toAct

                    }
                })
                .disposed(by: self.disposeBag)
            
            //아웃풋
            cell.genderView.manButton.rx.tap
                .bind(onNext: { _ in
                    self.viewModel.gender.accept(1)
                })
                .disposed(by: self.disposeBag)
            
            
            cell.genderView.womanButton.rx.tap
                .bind(onNext: { _ in
                    self.viewModel.gender.accept(0)
                })
                .disposed(by: self.disposeBag)
                
        
            
            // MARK: - 자주 하는 스터디
            //인풋
            self.viewModel.study
                .bind(to: cell.studyView.studyTextField.rx.text)
                .disposed(by:self.disposeBag)
            
            
            //거부: 0 허용: 1
            // MARK: - 내번호 검색 허용
            //인풋
            self.viewModel.searchable
                .bind(onNext: { able in
                    if able == 1 {
                        cell.switchView.switchUI.setOn(true, animated: true)
                    }
                })
                .disposed(by: self.disposeBag)
                
            
        
            //아웃풋
            cell.switchView.switchUI.rx.value
                .bind(onNext: { isOn in
                    if isOn { //true --> On
                        self.viewModel.searchable.accept(1) //허용
                        print(isOn)
                    } else {
                        self.viewModel.searchable.accept(0)
                    }
                })
                .disposed(by: self.disposeBag)
            
            // MARK: - 연령대, Slider
            //인풋 --> addTarget + delegate 이용

            //아웃풋
            self.viewModel.age //[Int]
                .map{ $0.map{ $0.toCGFloat } }
                .bind(onNext: { age in
                    print("🔥\(age)")
                    cell.ageView.multislider.value = age
                    cell.ageView.ageLabel.text = "\(age[0].toInt) - \(age[1].toInt)"
                })
                .disposed(by: self.disposeBag)
            
            // MARK: - 회원 탈퇴
            
            cell.withDrawView.withdrawButton.rx.tap
                .bind(onNext: { _ in
                    
                    let vc = SeSacAlertController()
                    
                    vc.completeButton.rx.tap
                        .bind(onNext: { _ in
                            //회원탈퇴 URLSession gogo
                            self.viewModel.requestWithdraw { result in
                                let vc = OnBoardingViewController()
                                switch result {
                                case .success: // 탈퇴 설공
                                    self.transitionRootViewController(vc)
                                case .failure: // 이미 탈퇴 되어 있음
                                    self.transitionRootViewController(vc)
                                }
                            }
                        })
                        .disposed(by: self.disposeBag)
                    
                    vc.cancelButton.rx.tap
                        .bind(onNext: { _ in
                            vc.dismiss(animated: false)
                        })
                        .disposed(by: self.disposeBag)
                    

                    
                    self.transition(vc, transitionStyle: .SeSacAlertController)
                })
                .disposed(by: self.disposeBag)
            
        }
        
    }

}

extension ProfileViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {

        if collectionView.indexPathsForSelectedItems?.contains(indexPath) ?? false {
            collectionView.deselectItem(at: indexPath, animated: true)
        } else {
            collectionView.selectItem(at: indexPath, animated: true, scrollPosition: [])
        }
        
        dataSource.refresh()
        
        return false
    }
}

extension ProfileViewController: MultiSliderEventDeledate {
    func slider(_ view: AgeView, slider: [Int]) {
        self.viewModel.age.accept(slider)
    }
}


extension UICollectionViewDiffableDataSource {
    typealias CellRegistraion = UICollectionView.CellRegistration
}
 

