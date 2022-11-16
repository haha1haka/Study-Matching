//
//  MyInfoDataSource.swift
//  Study-Matching
//
//  Created by HWAKSEONG KIM on 2022/11/17.
//

import UIKit


class GenderDataSource: UICollectionViewDiffableDataSource<Int, Int> {
    
    convenience init(collectionView: UICollectionView) {
        
        let cellRegistration = UICollectionView.CellRegistration<GenderCell,Int> { cell, indexPath, itemIdentifier in
            switch indexPath.item {
            case .zero:
                cell.imageView.image = UIImage(named: "man")
            default:
                cell.imageView.image = UIImage(named: "woman")
            }
            
        }
        
        self.init(collectionView: collectionView) {
            collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
            return cell
        }
    }

    func applySnapshot() {
        var snapshot = snapshot()
        snapshot.appendSections([0])
        snapshot.appendItems([1,2])
        apply(snapshot)
    }

}
