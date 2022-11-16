//
//  MyInfoDataSource.swift
//  Study-Matching
//
//  Created by HWAKSEONG KIM on 2022/11/17.
//

import UIKit

enum Section1 {
    case main
}
struct Setting: Hashable {
    let image: UIImage
    let label: String
    static let data = [Setting(image: SeSacImage.notice!, label: "공지사항"),
                       Setting(image: SeSacImage.faq!, label: "자주 묻는 질문"),
                       Setting(image: SeSacImage.qna!, label: "1:1 문의"),
                       Setting(image: SeSacImage.settingAlarm!, label: "알림 설정"),
                       Setting(image: SeSacImage.permit!, label: "이용 약관"),]
    
}


class MyInfoDataSource: UICollectionViewDiffableDataSource<Section, Setting> {
    
    convenience init(collectionView: UICollectionView) {
        
        let cellRegistration = UICollectionView.CellRegistration<MyInfoCell,Setting> { cell, indexPath, itemIdentifier in
            cell.imageView.image = itemIdentifier.image
            cell.label.text = itemIdentifier.label
        }
        
        self.init(collectionView: collectionView) {
            collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
            return cell
        }
        
        let headerRegistration = UICollectionView.SupplementaryRegistration<MyInfoHeaderView>(elementKind: UICollectionView.elementKindSectionHeader) { supplementaryView, elementKind, indexPath in
            //supplementaryView.nextButton.rx.tap
                //.bind(onNext: { _ in
                //    let vc = ProfileViewController()
                //    self.transition(vc, transitionStyle: .push)
                //})
                //.disposed(by: self.disposeBag)
            
        }
        
        supplementaryViewProvider =  { collectionView, elementKind, indexPath in
            let suppleymentaryView  = collectionView.dequeueConfiguredReusableSupplementary(using: headerRegistration, for: indexPath)
            return suppleymentaryView
        }
    }
    
    func applySnapshot() {
        var snapshot = snapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(Setting.data)
        apply(snapshot)
    }
    
}
