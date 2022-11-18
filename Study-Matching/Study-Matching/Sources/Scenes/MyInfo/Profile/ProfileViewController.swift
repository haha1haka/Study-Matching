import UIKit
import RxSwift
import RxCocoa

class ProfileViewController: BaseViewController {
    
    let selfView = ProfileView()
    override func loadView() {
        view = selfView
    }
    
    var maincellRegistration: UICollectionView.CellRegistration<ProfileMainCell, Main>?
    var subcellRegistration: UICollectionView.CellRegistration<ProfileSubCell, Sub>?

    lazy var dataSource = ProfileDataSource(collectionView: selfView.collectionView, self.maincellRegistration!, self.subcellRegistration!)
    
    let viewModel = ProfileViewModel()
    let disposeBag = DisposeBag()
    
    
    var mainCell: UICollectionViewCell?
}

extension ProfileViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        //print(dataSource.itemIdentifier(for: IndexPath(item: 1, section: 0)))
        dataSource.snapshot()
        dataSource.applyInitialSnapshot()
        
        selfView.collectionView.delegate = self
        print("🟥\(self.selfView.collectionView.cellForItem(at: IndexPath(row: 0, section: 1)) as? ProfileMainCell)")
        //dataSource.delegate = self
        //print("🟥\(mainCell)")
//        mainCell?.cardStackView.button1.rx.tap
//            .bind(onNext: { _ in
//                print("")
//            })
//            .disposed(by: disposeBag)
        
        
    }
}
extension ProfileViewController {

    func bind() {
        maincellRegistration = UICollectionView.CellRegistration<ProfileMainCell,Main> { cell, indexPath, itemIdentifier in
            cell.cardStackView.button1.rx.tap
                .bind(onNext: { _ in
                    print("fdsfsd")
                })
                .disposed(by: self.disposeBag)
            
        }
        
        
        subcellRegistration = UICollectionView.CellRegistration<ProfileSubCell,Sub> { cell, indexPath, itemIdentifier in
                    
        }
        
    }
}

extension ProfileViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        //var snapshot = dataSource.snapshot()
        //print(dataSource.itemIdentifier(for: indexPath))
        
        print("🔥\(indexPath)")
        
        print("🟥\(selfView.collectionView.cellForItem(at: indexPath) as? ProfileMainCell)")
        //let mian  =
        //mainCell.rx.tap
          
        if collectionView.indexPathsForSelectedItems?.contains(indexPath) ?? false {
            collectionView.deselectItem(at: indexPath, animated: true)
        } else {
            collectionView.selectItem(at: indexPath, animated: true, scrollPosition: [])
        }
        
        dataSource.refresh()
        
        return false
    }
    
}

extension ProfileViewController: ProfileDataSourceDelegate {
    func mainCell(maincell: ProfileMainCell) {
        print("")
    }
    
    func subCell(subcell: ProfileSubCell) {
        print(subcell)
        subcell.genderView.manButton.rx.tap
            .bind(onNext: { _ in
                print("fasfdsa")
            })
            .disposed(by: disposeBag)
        
        subcell.genderView.womanButton.rx.tap
            .bind(onNext: { _ in
                print("")
            })
            .disposed(by: disposeBag)
        
    }
    //
    //
    //
    //
    //
    //}
}
