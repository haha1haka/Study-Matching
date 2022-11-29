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
    
    // MARK: - ProfileVC
    typealias ProfileHeaderRegistration    = UICollectionView.SupplementaryRegistration<ProfileHeaderView>
    typealias ProfileMainCellRegistration  = UICollectionView.CellRegistration<ProfileMainCell, Main>
    typealias ProfileSubCellRegistration   = UICollectionView.CellRegistration<ProfileSubCell, Sub>
    
    
    // MARK: - SearchVC
    typealias SearchHeaderRegistration    = UICollectionView.SupplementaryRegistration<WishListHeaderView>
    typealias SearchTopCellRegistration  = UICollectionView.CellRegistration<WishListTopCell, Nearby>
    typealias SearchBottomCellRegistration   = UICollectionView.CellRegistration<WishListBottomCell, Wanted>
    
    // MARK: - RequestedVC
    typealias CardHeaderRegistration    = UICollectionView.SupplementaryRegistration<CardCollectionHeaderView>
    typealias CardCellRegistration  = UICollectionView.CellRegistration<CardCollectionCell, Card>
    
    // MARK: - Chat
    typealias ChatHeaderRegistration    = UICollectionView.SupplementaryRegistration<ChatHeaderView>
    typealias ChatLeftCellRegistration  = UICollectionView.CellRegistration<ChatLeftCell, Left>
    typealias ChatRightCellRegistration   = UICollectionView.CellRegistration<ChatRightCell, Right>
    
}
