import UIKit
import RxSwift
import RxCocoa
import RealmSwift
import SnapKit
import RxRealm

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
    
    let socketIOManager = SocketIOManager.shared
    let viewModel = ChatViewModel()
    let disposeBag = DisposeBag()
    
    let chatRepository = ChatRepository()

    var chatDataBase: Results<Chat>!
    
    
    
    override func loadView() { view = selfView }
    
    override func setNavigationBar(title: String, rightTitle: String) {
        super.setNavigationBar(title: "고래밥")
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: SeSacImage.more, style: .plain, target: nil, action: nil)
        self.navigationController?.isNavigationBarHidden = false
        self.tabBarController?.tabBar.isHidden = true
    }

    
}

extension ChatViewController {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        socketIOManager.establishConnection()
        checkQueueState()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        viewModel.fetchChat()
        
        socketIOManager.eventDelegate = self
        selfView.collectionView.delegate = self
        bind()
        
        
        
        
        
        
        
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        socketIOManager.closeConnection()
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
        
        self.navigationItem.rightBarButtonItem?.rx.tap
            .bind(onNext: { [weak self]_ in
                guard let self = self else { return }
                self.viewModel.requestDodge { _ in
                    return
                }
            })
            .disposed(by: disposeBag)
        
        
        
        
//        viewModel.live
//            .bind(onNext: {
//                var snashot = self.dataSource.snapshot()
//                snashot.deleteAllItems()
//                snashot.appendSections([0])
//                snashot.appendItems($0)
//                self.dataSource.apply(snashot)
//            })
//            .disposed(by: disposeBag)
        
        
        
        
        
        selfView.sendButton.rx.tap
            .bind(onNext: {
                
                self.sendChat()
                
                print(self.viewModel.chatDataBase)
                
                self.selfView.textView.text = ""
            })
            .disposed(by: self.disposeBag)
        

        
        
        
//        Observable.changeset(from: viewModel.chatDataBase)
//            .bind(onNext: { array, changes in
//
//
//
//                var snapshot = self.dataSource.snapshot()
//                snapshot.deleteAllItems()
//                snapshot.appendSections([0])
//
//                snapshot.appendItems(array.toArray(), toSection: 0)
//
//
//
//
//                //snashot.reconfigureItems(array.toArray())
//                self.dataSource.apply(snapshot)
//            })
//            .disposed(by: self.disposeBag)
//        Observable.of(viewModel.dataList)
//            .bind(onNext: {
//                print("🟥\($0)")
//            })
//            .disposed(by: self.disposeBag)
        
        
        
        viewModel.liveChat
            .bind(onNext: { a in
                print("🐶🐶🐶🐶🐶\(a)")
                var snapshot = NSDiffableDataSourceSnapshot<Int, Chat>()
                //snapshot.deleteAllItems()
                snapshot.appendSections([0])
                if !snapshot.sectionIdentifiers.isEmpty {
                    snapshot.appendItems(a,toSection: 0)
                }
                
                self.dataSource.apply(snapshot)
            })
            .disposed(by: disposeBag)
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
//    func dodge() {
//        self.viewModel.requestDodge {
//
//
//        }
//    }
}





extension ChatViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selfView.textView.resignFirstResponder()
    }
}


extension ChatViewController: SocketEventDelegate {
    func chat(_ manager: SocketIOManager,_  item: Chat) {
        print("라이브 통신 Chat \(item.chat)")
        
        
        viewModel.arr.append(item)
        self.viewModel.liveChat.accept(viewModel.arr)
    }
}





//extension ChatViewController: socketEventDelegate {
//    func chat(_ object: WebSocketService, _ item: String) {
//        print("🥹🥹🥹🥹\(item)")
//    }
//}
 



//extension ChatViewController: URLSessionWebSocketDelegate {
//    func urlSession(_ session: URLSession, webSocketTask: URLSessionWebSocketTask, didOpenWithProtocol protocol: String?) {
//        print("CONNECTCONNECTCONNECTCONNECT")
//    }
//    func urlSession(_ session: URLSession, webSocketTask: URLSessionWebSocketTask, didCloseWith closeCode: URLSessionWebSocketTask.CloseCode, reason: Data?) {
//        print("CLOSECLOSECLOSECLOSECLOSECLOSE")
//    }
//}
