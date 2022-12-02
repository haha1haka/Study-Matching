import Foundation
import SocketIO

final class SocketIOManager: NSObject {
    
    static let shared = SocketIOManager()
    
    let chatRepository = RMChatRepository()
    
    var manager: SocketManager!
    var socket: SocketIOClient!
    
    
    let idToken = UserDefaultsManager.standard.idToken
    
    override init() {
        super.init()
        let baseURL: String = "http://api.sesac.co.kr:1210"
        guard let socketURL = URL(string: baseURL) else { return }
        manager = SocketManager(socketURL: socketURL, config: [
            .log(true),
            .extraHeaders(["auth": idToken]) //일단 해쉬한값 넣어주는 건가?
        ])
        
        socket = manager.defaultSocket
        

        socket.on(clientEvent: .connect) { data, ack in
            print("SOCKET IS CONNECTED", data, ack)
        }
        
        socket.on(clientEvent: .disconnect) { data, ack in
            print("SOCKET IS DISCONNECTED", data, ack)
        }
        
        
        socket.on("chat") { dataArray, ack in
            print("SESAC RECEIVED", dataArray)
            let data = dataArray[0] as! NSDictionary
            let chat = data["chat"] as! String
            let from = data["from"] as! String
            let to = data["to"] as! String
            let createdAt = data["createdAt"] as! String
            
            
            print("CHECK >>>", chat, createdAt)
            
            let rmChat = RMChat(from: from, to: to, chat: chat, createdAt: createdAt)
            
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

