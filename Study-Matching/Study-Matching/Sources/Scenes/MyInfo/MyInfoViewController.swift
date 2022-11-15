import UIKit

//망한코드
enum ListItem: Hashable {
    case header(HeaderItem)
    case items(Items)
}

struct HeaderItem: Hashable {
    
    static func == (lhs: HeaderItem, rhs: HeaderItem) -> Bool {
        lhs.id == rhs.id
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    var id = UUID()
    var title: String
    var items: [Items]
}

//struct Items: Hashable {
//    var item1: Item1
//    var item2: Item2
//    var item3: Item3
//}
enum Items: Hashable {
    case item1(Item1)
    case item2(Item2)
    case item3(Item3)
}


struct Item1: Hashable {
    var title: String
}
struct Item2: Hashable {
    var title: String
}
struct Item3: Hashable {
    var title: String
}



class MyInfoViewController: BaseViewController {
    let selfView = MyInfoView()
    override func loadView() {
        view = selfView
    }
    var collectionViewDataSource: UICollectionViewDiffableDataSource<String, ListItem>!
    
    
    let objects = [HeaderItem(title: "1", items:[Items.item1(Item1(title: "첫번째 셀")),
                                                Items.item2(Item2(title: "두번째 셀")),
                                                Items.item3(Item3(title: "세번째 셀"))])]
}

extension MyInfoViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
}
extension MyInfoViewController {
    func configureCollectionViewDataSource() {
        
        let headerRegistration = UICollectionView.SupplementaryRegistration<MyInfoHeaderView>(elementKind: UICollectionView.elementKindSectionHeader) { supplementaryView, elementKind, indexPath in
        }
        
        let cellRegistration = UICollectionView.CellRegistration<HeaderCell,HeaderItem> { cell, indexPath, itemIdentifier in
        }
        let cellRegistration1 = UICollectionView.CellRegistration<ItemCell1,Item1> { cell, indexPath, itemIdentifier in
            cell.backgroundColor = .red
        }
        let cellRegistration2 = UICollectionView.CellRegistration<ItemCell2,Item2> { cell, indexPath, itemIdentifier in
            cell.backgroundColor = .green
        }
        let cellRegistration3 = UICollectionView.CellRegistration<ItemCell3,Item3> { cell, indexPath, itemIdentifier in
            cell.backgroundColor = .yellow
        }
        
        collectionViewDataSource.supplementaryViewProvider =  { collectionView, elementKind, indexPath in
            let suppleymentaryView  = self.selfView.collectionView.dequeueConfiguredReusableSupplementary(using: headerRegistration, for: indexPath)
            
            return suppleymentaryView
        }
        
        collectionViewDataSource = UICollectionViewDiffableDataSource<String, ListItem>(collectionView: selfView.collectionView) {
            collectionView, indexPath, itemIdentifier in
            
            switch itemIdentifier {
            case .header(let headeritem):
                let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: headeritem)
                return cell
                
            case .items(let items):
                switch items {
                case .item1(let item):
                    let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration1, for: indexPath, item: item)
                    return cell
                case .item2(let item):
                    let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration2, for: indexPath, item: item)
                    return cell
                case .item3(let item):
                    let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration3, for: indexPath, item: item)
                    return cell
                }
                
                
                
            }
            
        }
        
        
        
        
        
    }
    
    func applySnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<String, ListItem>()
        snapshot.appendSections(["HeaderCell"])
        collectionViewDataSource.apply(snapshot)
        var sectionSnapshot = NSDiffableDataSourceSectionSnapshot<ListItem>()
        let headerItem = ListItem.header(HeaderItem(title: "김새싹", items: <#T##[Items]#>))
        
        
    }
}

extension MyInfoViewController {
    
}


