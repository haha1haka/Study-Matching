//
//  MyInfoDataSource.swift
//  Study-Matching
//
//  Created by HWAKSEONG KIM on 2022/11/17.
//

import UIKit


class GenderDataSource: UICollectionViewDiffableDataSource<Int, Int>, DataSourceRegistration {
    
    convenience init(collectionView: UICollectionView,
                     cellRegistration: GenderCellRegistration)
    {
        self.init(collectionView: collectionView) {
            collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(
                using: cellRegistration,
                for: indexPath,
                item: itemIdentifier)
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
