import UIKit
import RxSwift
import RxCocoa
import MultiSlider

class ProfileViewController: BaseViewController {
    
    let selfView = ProfileView()
    override func loadView() {
        view = selfView
    }
    
    var mainCellRegistration: UICollectionView.CellRegistration<ProfileMainCell, MemoleaseUser>?
    var subcCellRegistration: UICollectionView.CellRegistration<ProfileSubCell, MemoleaseUser>?

    lazy var dataSource = ProfileDataSource(
        collectionView: selfView.collectionView,
                        self.mainCellRegistration!,
                        self.subcCellRegistration!)
    
    let viewModel = MyInfoViewModel.shared
    let disposeBag = DisposeBag()
    
}

extension ProfileViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        registeredCell()
        applyInitialSnapshot()
        selfView.collectionView.delegate = self
        
    }
    
    func applyInitialSnapshot() {
        var snapshot = dataSource.snapshot()
        snapshot.appendSections([0, 1])
        snapshot.appendItems([Item.main(viewModel.user.value!)])
        snapshot.appendItems([Item.sub(viewModel.user.value!)])
        dataSource.apply(snapshot)
    }
}

extension ProfileViewController {
    func setData() {

    }
}



extension ProfileViewController {
    func registeredCell() {
        mainCellRegistration = UICollectionView.CellRegistration<ProfileMainCell,MemoleaseUser> { cell, indexPath, itemIdentifier in
            cell.configure(with: itemIdentifier)
            // MARK: - 김새싹
            self.viewModel.nick
                .bind(to: cell.nameLabel.rx.text)
                .disposed(by: self.disposeBag)
            

            // MARK: - 버튼 6개
            self.viewModel.reputation
                .bind(onNext: { arr in
                    [cell.cardStackView.button0, cell.cardStackView.button1, cell.cardStackView.button2, cell.cardStackView.button3, cell.cardStackView.button4, cell.cardStackView.button5].forEach {
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
        
        
        subcCellRegistration = UICollectionView.CellRegistration<ProfileSubCell,MemoleaseUser> { cell, indexPath, itemIdentifier in
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
                .bind(to: cell.studyView.studyLable.rx.text)
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
                    cell.ageView.multislider.value = age

                    cell.ageView.ageLabel.text = "\(age[0].toInt) - \(age[1].toInt)"
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
 

