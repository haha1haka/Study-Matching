import UIKit
import RxSwift
import RxCocoa
import RealmSwift
import SnapKit
import RxRealm

class ChatViewController: BaseViewController, DataSourceRegistration {
    
    
    let selfView = ChatView()
    
    var header1: ChatHeaderRegistration1?
    var header2: ChatHeaderRegistration2?
    var leftCell: ChatLeftCellRegistration?
    var rightCell: ChatRightCellRegistration?

    lazy var dataSource = ChatDataSource(
        collectionView      : selfView.collectionView,
        headerRegistration1  : self.header1!,
        headerRegistration2  : self.header2!,
        chatLeftRegistration: self.leftCell!,
        chatRightRegitstrion : self.rightCell!)
    
    let socketIOManager = SocketIOManager.shared
    let viewModel = ChatViewModel()
    let disposeBag = DisposeBag()
    
    let chatRepository = ChatRepository()
    var flag = false

    var chatDataBase: Results<Chat>!
    
    
    
    override func loadView() { view = selfView }
    
    override func setNavigationBar(title: String, rightTitle: String) {
        super.setNavigationBar(title: "\(UserDefaultsManager.standard.matchedNick)")
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: SeSacImage.more, style: .plain, target: nil, action: nil)
        self.navigationController?.isNavigationBarHidden = false
        self.tabBarController?.tabBar.isHidden = true
    }

    
}

extension ChatViewController {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        checkQueueState {
            self.viewModel.fetchRealmChat {  //database
                self.fetchLastChats() //payload
                
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        socketIOManager.eventDelegate = self
        selfView.collectionView.delegate = self
        bind()
        //selfView.collectionView.scrollToBottom(animated: false)

        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let attributes = self.selfView.collectionView.collectionViewLayout.layoutAttributesForSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, at: IndexPath(item: 0, section: 1)) {
            self.selfView.collectionView.setContentOffset(CGPoint(x: 0, y: attributes.frame.origin.y - 100), animated: true)
        }
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        socketIOManager.closeConnection()
    }
    
}

extension ChatViewController {
    func bind() {
        
        header1 = ChatHeaderRegistration1 (elementKind: UICollectionView.elementKindSectionHeader)
        {  supplementaryView, elementKind, indexPath in
            
        }
        
        header2 = ChatHeaderRegistration2 (elementKind: "aa")
        {  supplementaryView, elementKind, indexPath in
            
        }
        
        leftCell = ChatLeftCellRegistration
        {  cell, indexPath, itemIdentifier in
            cell.configureCell(with: itemIdentifier)
        }
        
        rightCell = ChatRightCellRegistration
        {  cell, indexPath, itemIdentifier in
            cell.configureCell(with: itemIdentifier)
        }
        
        self.navigationItem.rightBarButtonItem?.rx.tap
            .bind(onNext: { [weak self]_ in
                guard let self = self else { return }
                self.viewModel.requestDodge { _ in
                    return
                }
            })
            .disposed(by: disposeBag)
        
    
        
        
        
        
        
        selfView.sendButton.rx.tap
            .bind(onNext: {
                self.sendChat()
                self.selfView.textView.text = ""
            })
            .disposed(by: self.disposeBag)
        
        
        
        var snapshot = NSDiffableDataSourceSnapshot<Int, Chat>()
        snapshot.appendSections([0, 1])
        
        viewModel.payloadChat
            .bind(onNext: { payloadChat in //[Chat]
                
                
                //1. 램 마지막 날짜 가져오기, --> 2. 그걸로 payload 가져 오기 --> 3. 
                snapshot.appendItems(self.viewModel.chatDataBase.toArray(),toSection: 0)
                                
                //snapshot.deleteAllItems()
                
                if !snapshot.sectionIdentifiers.isEmpty {
                    snapshot.appendItems(payloadChat,toSection: 0)
                }
                
                self.dataSource.apply(snapshot)
                
                if payloadChat.count > 0 {
                    //let index = IndexPath(row: payloadChat.count - 1, section: 0)
                    //self.selfView.collectionView.scrollToItem(at: index, at: .bottom, animated: true)
                }
            })
            .disposed(by: disposeBag)
        
        
        viewModel.liveChat.bind(onNext: { socketChat in // [Chat]
            print("라이브채팅중인 내용 \(socketChat)")
            

            if !snapshot.sectionIdentifiers.isEmpty {
                snapshot.appendItems(socketChat,toSection: 1)
            }
            
            self.dataSource.apply(snapshot)
            
            if socketChat.count > 0 {
                let index = IndexPath(row: self.viewModel.liveChat.value.count - 1, section: 1)
                DispatchQueue.main.async {
                    self.selfView.collectionView.scrollToItem(at: index, at: .bottom, animated: true)
                }
                
                
                //self.selfView.collectionView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
            }

        })
        .disposed(by: disposeBag)
        
        
        selfView.textView.rx.didBeginEditing
            .bind(onNext: {
                if let attributes = self.selfView.collectionView.collectionViewLayout.layoutAttributesForSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, at: IndexPath(item: 0, section: 1)) {
                    self.selfView.collectionView.setContentOffset(CGPoint(x: 0, y: attributes.frame.origin.y - 244), animated: true)
                }
            })
            .disposed(by: disposeBag)
            
        

        
    }
    

    

    
    
    
}




extension ChatViewController {
    func checkQueueState(completion: @escaping () -> Void) {
        self.viewModel.checkQueueState {
            switch $0 {
            case .success:
                print("매칭이 성공 되었습니다.")
                // MARK: - lastChat 불러오기
                completion()
                return
            case .failure(let error):
                switch error {
                case .canceledMatch:
                    print("상대방 탈주잼")
                case .idTokenError:
                    self.checkQueueState{}
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
    func fetchLastChats() {
        viewModel.fetchLastChat {
            switch $0 {
            case .success:
                self.socketIOManager.establishConnection()
            case .failure(let error):
                switch error {
                case .idTokenError:
                    self.fetchLastChats()
                default:
                    return
                }
            }
        }
    }
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
        viewModel.liveChat.accept(viewModel.arr)
        //self.viewModel.payloadChat.accept(viewModel.arr)
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
