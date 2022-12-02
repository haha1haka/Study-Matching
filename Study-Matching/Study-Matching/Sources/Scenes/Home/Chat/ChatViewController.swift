import UIKit
import RxSwift
import RxCocoa

class ChatViewController: BaseViewController, DataSourceRegistration {
    

    let selfView = ChatView()
    var header: ChatHeaderRegistration?
    var leftCell: ChatLeftCellRegistration?
    var rightCell: ChatRightCellRegistration?
    
    lazy var dataSource = ChatDataSource(
        collectionView      : selfView.collectionView,
        headerRegistration  : self.header!,
        chatLeftRegistration: self.leftCell!,
        chatRightRegitstrion : self.rightCell!)
        
    //let viewModel = MyInfoViewModel.shared
    let disposeBag = DisposeBag()
    
    override func loadView() { view = selfView }
    
    override func setNavigationBar(title: String, rightTitle: String) {
        super.setNavigationBar(title: "고래밥")
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: SeSacImage.more, style: .plain, target: nil, action: nil)
    }
}

extension ChatViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        applySnapshot()
    }
}

extension ChatViewController {
    func bind() {
        
        header = ChatHeaderRegistration (elementKind: UICollectionView.elementKindSectionHeader)
        { [weak self] supplementaryView, elementKind, indexPath in
                            
        }
        
        leftCell = ChatLeftCellRegistration
        { [weak self] cell, indexPath, itemIdentifier in
            cell.label.text = itemIdentifier.text
        
        }
        
        rightCell = ChatRightCellRegistration
        { [weak self] cell, indexPath, itemIdentifier in
            cell.label.text = itemIdentifier.text
        
        }
    }
    
}

extension ChatViewController {
    
    func applySnapshot() {
        var snapshot = dataSource.snapshot()
        snapshot.appendSections([0])
        snapshot.appendItems([ChatItem.left(Left(text: "안녕 바보야안녕안녕 바보야안녕안녕"))])
        snapshot.appendItems([ChatItem.right(Right(text: "응 너가 더 바보"))])
        dataSource.apply(snapshot)
    }
}

