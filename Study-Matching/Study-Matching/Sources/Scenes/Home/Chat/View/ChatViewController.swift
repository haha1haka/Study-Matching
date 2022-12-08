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
        checkQueueState {
            self.viewModel.fetchRealmChat { //database
                self.fetchLastChats() //payload
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
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
        
        header1 = ChatHeaderRegistration1 (elementKind: UICollectionView.elementKindSectionHeader)
        {  supplementaryView, elementKind, indexPath in
            
        }
        
        header2 = ChatHeaderRegistration2 (elementKind: UICollectionView.elementKindSectionHeader)
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
        
        viewModel.chatDataBase.value
        
        
        
        selfView.sendButton.rx.tap
            .bind(onNext: {
                
                self.sendChat()
                
                print("램 에 채팅 로그 \(self.viewModel.chatDataBase.value)")
                
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
        
        var snapshot = NSDiffableDataSourceSnapshot<Int, Chat>()
        snapshot.appendSections([0, 1])
        viewModel.payloadChat
            .bind(onNext: { a in //[Chat]
                print("🐶🐶🐶🐶🐶\(a)")
                
                //1. 램 마지막 날짜 가져오기, --> 2. 그걸로 payload 가져 오기 --> 3. 
                snapshot.appendItems(self.viewModel.chatDataBase.toArray(),toSection: 0)
                                
                //snapshot.deleteAllItems()
                
                if !snapshot.sectionIdentifiers.isEmpty {
                    snapshot.appendItems(a,toSection: 0)
                }
                
                self.dataSource.apply(snapshot)
            })
            .disposed(by: disposeBag)
        
        
        viewModel.liveChat.bind(onNext: { a in // [Chat]
            print("라이브채팅중인 내용 \(a)")
            
            //var snapshot = NSDiffableDataSourceSnapshot<Int, Chat>()
            //snapshot.appendSections([1])
            if !snapshot.sectionIdentifiers.isEmpty {
                snapshot.appendItems(a,toSection: 1)
            }
            
            self.dataSource.apply(snapshot)
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
