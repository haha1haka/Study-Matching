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
            //cell.configure(with: itemIdentifier)
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
            //cell.configure(with: itemIdentifier)
//             MARK: - 성별
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
                
        
            
            // MARK: - 스터디
            // MARK: - 내 번호 검색 허용
            // MARK: - 연령대
            
            // MARK: - switch
            cell.switchView.switchUI.rx.value
                .bind(onNext: { b in
                    if b {
                        self.viewModel.searchable.accept(1)
                    } else {
                        self.viewModel.searchable.accept(0)
                    }
                })
                .disposed(by: self.disposeBag)
            
            // MARK: - Slider
                

            
                
                    
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

extension UICollectionViewDiffableDataSource {
    typealias CellRegistraion = UICollectionView.CellRegistration
}

//extension Reactive where Base: MultiSlider {
//
//    /// Reactive wrapper for `value` property.
//    public var value: ControlProperty<Float> {
//        return base.rx.controlPropertyWithDefaultEvents(
//            getter: { slider in
//                slider.value
//            }, setter: { slider, value in
//                slider.value = value
//            }
//        )
//    }
//
//}
