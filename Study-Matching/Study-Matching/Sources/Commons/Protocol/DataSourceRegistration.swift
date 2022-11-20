import UIKit

protocol DataSourceRegistration {
    
    // MARK: - GenderVC
    typealias GenderCellRegistration       = UICollectionView.CellRegistration<GenderCell,Int>
    
    // MARK: - OnBoardingBV
    typealias OnBoardingCellRegistration   = UICollectionView.CellRegistration<OnboardCell, Page>
    typealias OnBoardingFooterRegistration = UICollectionView.SupplementaryRegistration<OnBoardingFooterView>
    
    // MARK: - MyInfoVC
    typealias MyInfoCellRegistration       = UICollectionView.CellRegistration<MyInfoCell,Setting>
    typealias MyInfoHeaderRegistration     = UICollectionView.SupplementaryRegistration<MyInfoHeaderView>
    
    typealias ProfileHeaderRegistration    = UICollectionView.SupplementaryRegistration<ProfileHeaderView>
    typealias ProfileMainCellRegistration  = UICollectionView.CellRegistration<ProfileMainCell, Main>
    typealias ProfileSubCellRegistration   = UICollectionView.CellRegistration<ProfileSubCell, Sub>
}
