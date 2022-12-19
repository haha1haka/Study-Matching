import UIKit
import RxSwift
import RxCocoa
import MultiSlider



class ProfileViewController: BaseViewController, DataSourceRegistration {
    
    let selfView = ProfileView()
    
    override func loadView() { view = selfView }
    
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

    override func setNavigationBar(title: String, rightTitle: String) {
        super.setNavigationBar(title: "내정보", rightTitle: "저장")
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
                        DispatchQueue.main.async {
                            self.showToastAlert(message: "성공정으로 정보가 저장 되었습니다.") {
                                self.navigationController?.dismiss(animated: true)
                            }
                        }
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
                    supplementaryView.mainImageView.image = SeSacImage.sesacBackgroundImageArray[int]
                })
                .disposed(by: self.disposeBag)
            
            self.viewModel.sesac
                .bind(onNext: { int in
                    supplementaryView.subImageView.image = SeSacImage.sesacImageArray[int]
                })
                .disposed(by: self.disposeBag)
        }
        
        mainCell = ProfileMainCellRegistration
        { [weak self] cell, indexPath, itemIdentifier in
            guard let self = self else { return }
            
            self.viewModel.nick
                .bind(to: cell.nameLabel.rx.text)
                .disposed(by: self.disposeBag)
            
            
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
            
            self.viewModel.study
                .bind(to: cell.studyView.studyTextField.rx.text)
                .disposed(by:self.disposeBag)
            
            self.viewModel.searchable
                .bind(onNext: { able in
                    if able == 1 {
                        cell.switchView.switchUI.setOn(true, animated: true)
                    }
                })
                .disposed(by: self.disposeBag)
            
            cell.switchView.switchUI.rx.value
                .bind(onNext: { isOn in
                    if isOn {
                        self.viewModel.searchable.accept(1) //허용
                        print(isOn)
                    } else {
                        self.viewModel.searchable.accept(0)
                    }
                })
                .disposed(by: self.disposeBag)
            
            self.viewModel.age //[Int]
                .map{ $0.map{ $0.toCGFloat } }
                .bind(onNext: { age in
                    cell.ageView.multislider.value = age
                    cell.ageView.ageLabel.text = "\(age[0].toInt) - \(age[1].toInt)"
                })
                .disposed(by: self.disposeBag)
            
            cell.withDrawView.withdrawButton.rx.tap
                .bind(onNext: { _ in
                    let vc = SeSacAlertController(alertType: .myInfo)
                    vc.completeButton.rx.tap
                        .bind(onNext: { _ in
                            self.viewModel.requestWithdraw { result in
                                let vc = OnBoardingViewController()
                                switch result {
                                case .success: // 탈퇴 설공
                                    self.transitionRootViewController(vc, transitionStyle: .toRootWithNavi)
                                case .failure: // 이미 탈퇴 되어 있음
                                    self.transitionRootViewController(vc, transitionStyle: .toRootWithNavi)
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

