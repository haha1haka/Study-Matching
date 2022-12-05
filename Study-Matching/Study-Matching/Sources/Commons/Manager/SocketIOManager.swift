import Foundation
import SocketIO

protocol SocketEventDelegate: AnyObject {
    func chat(_ manager: SocketIOManager,_ item: Chat)
}

class SocketIOManager: NSObject {
    
    static let shared = SocketIOManager()
    
    let chatRepository = ChatRepository()
    
    var eventDelegate: SocketEventDelegate?
    
    
    var manager: SocketManager!
    var socket: SocketIOClient!
    
    
    let myUid = UserDefaultsManager.standard.myUid
    
    private override init() {
        super.init()
        let baseURL: String = "http://api.sesac.co.kr:1210"
        guard let socketURL = URL(string: baseURL) else { return }
        manager = SocketManager(socketURL: socketURL, config: [
            .log(true),
            .forceWebsockets(true)

        ])
        
        socket = manager.defaultSocket
        

        socket.on(clientEvent: .connect) { data, ack in
            print("🫡SOCKET IS CONNECTED", data, ack)
            self.socket.emit("changesocketid", self.myUid)
        }
        
        socket.on(clientEvent: .disconnect) { data, ack in
            print("💀SOCKET IS DISCONNECTED", data, ack)
        }
        
        
        socket.on("chat") { dataArray, ack in
            print("SESAC RECEIVED", dataArray)
            let data = dataArray[0] as! NSDictionary
            let to = data["to"] as! String
            let from = data["from"] as! String
            let chat = data["chat"] as! String
            let createdAt = data["createdAt"] as! String
            
            
            print("CHECK >>>", chat, createdAt)
            
            UserDefaultsManager.standard.lastChatDate = createdAt
            
            let rmChat = Chat(id: "", from: from, to: to, chat: chat, createdAt: createdAt)
            
            self.eventDelegate?.chat(self, rmChat)
            
            
            
            self.chatRepository.addChat(item: rmChat)
            
        }
        
    }
    
    func establishConnection() {
        socket.connect()
    }
    
    func closeConnection() {
        socket.disconnect()
    }
    
}

