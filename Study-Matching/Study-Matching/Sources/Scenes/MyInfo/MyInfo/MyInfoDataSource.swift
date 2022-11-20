//
//  MyInfoDataSource.swift
//  Study-Matching
//
//  Created by HWAKSEONG KIM on 2022/11/17.
//

import UIKit




class MyInfoDataSource: UICollectionViewDiffableDataSource<MyInfoSection, Setting>, DataSourceRegistration {
    
    convenience init(collectionView: UICollectionView,
                     headerRegistration: MyInfoHeaderRegistration,
                     cellRegistration: MyInfoCellRegistration)
    {
        
        self.init(collectionView: collectionView) {
            collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(
                using: cellRegistration,
                for: indexPath,
                item: itemIdentifier)
            return cell
        }
    
        supplementaryViewProvider =  { collectionView, elementKind, indexPath in
            let suppleymentaryView  = collectionView.dequeueConfiguredReusableSupplementary(
                using: headerRegistration,
                for: indexPath)
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


enum MyInfoSection {
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
