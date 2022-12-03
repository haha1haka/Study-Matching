import UIKit
import RxSwift
import RxCocoa

class ChatViewController: BaseViewController, DataSourceRegistration {
    
    
    let selfView = ChatView()
    var header: ChatHeaderRegistration?
    var leftCell: ChatLeftCellRegistration?
    var rightCell: ChatRightCellRegistration?
    
    let socketIOManager = SocketIOManager()
    
    
    var chatList: [Chat] = []
    
    
    
    lazy var dataSource = ChatDataSource(
        collectionView      : selfView.collectionView,
        headerRegistration  : self.header!,
        chatLeftRegistration: self.leftCell!,
        chatRightRegitstrion : self.rightCell!)
    
    let viewModel = ChatViewModel()
    let disposeBag = DisposeBag()
    
    override func loadView() { view = selfView }
    
    override func setNavigationBar(title: String, rightTitle: String) {
        super.setNavigationBar(title: "고래밥")
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: SeSacImage.more, style: .plain, target: nil, action: nil)
    }
}

extension ChatViewController {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        SocketIOManager.shared.establishConnection()
        checkQueueState()
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        SocketIOManager.shared.eventDelegate = self
        bind()
        applySnapshot()
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        SocketIOManager.shared.closeConnection()
    }
    
}

extension ChatViewController {
    func bind() {
        
        header = ChatHeaderRegistration (elementKind: UICollectionView.elementKindSectionHeader)
        {  supplementaryView, elementKind, indexPath in
            
        }
        
        leftCell = ChatLeftCellRegistration
        {  cell, indexPath, itemIdentifier in
            cell.label.text = itemIdentifier.chat
            
        }
        
        rightCell = ChatRightCellRegistration
        {  cell, indexPath, itemIdentifier in
            cell.label.text = itemIdentifier.chat
            
        }
        
        
        
        selfView.sendButton.rx.tap
            .bind(onNext: {
                
                self.sendChat()
                
                self.selfView.textView.text = ""
            })
            .disposed(by: self.disposeBag)
        
    }
    
}




extension ChatViewController {
    func checkQueueState() {
        self.viewModel.checkQueueState {
            switch $0 {
            case .success:
                print("매칭이 성공 되었습니다.")
                // MARK: - lastChat 불러오기
                
                return
            case .failure(let error):
                switch error {
                case .canceledMatch:
                    print("상대방 탈주잼")
                case .idTokenError:
                    self.checkQueueState()
                default:
                    return
                }
            }
        }
    }
    func sendChat() {
        guard let chatText = self.selfView.textView.text else { return }
        self.viewModel.sendChat(chatText: chatText) {
            switch $0 {
            case .success:
                return
            case .failure(let error):
                switch error {
                case .unableChat:
                    print("채팅을 할수가 없어요")
                    return
                case .idTokenError:
                    self.self.sendChat()
                    return
                default:
                    return
                }
                
            }
            
        }
    }
}





extension ChatViewController {
    
    func applySnapshot() {
        var snapshot = dataSource.snapshot()
        snapshot.appendSections([0])
        snapshot.appendItems(chatList)
        dataSource.apply(snapshot)
    }
}

extension ChatViewController: socketEventDelegate {
    func chat(_ manager: SocketIOManager,_  item: Chat) {
        self.chatList.append(item)
    }
}
