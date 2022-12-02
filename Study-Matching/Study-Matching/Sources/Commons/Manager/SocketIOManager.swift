import Foundation
import SocketIO

final class SocketIOManager: NSObject {
    
    static let shared = SocketIOManager()
    
    var manager: SocketManager!
    var socket: SocketIOClient!
    let idToken = UserDefaultsManager.standard.idToken
    
    override init() {
        super.init()
        let baseURL: String = "http://api.sesac.co.kr:1210"
        guard let socketURL = URL(string: baseURL) else { return }
        manager = SocketManager(socketURL: socketURL, config: [
            .log(true),
            .extraHeaders(["auth": idToken])
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
            
            
            // 프로토콜로 하기
            // MARK: -1
            NotificationCenter.default.post(name: NSNotification.Name("getMessage"), object: self, userInfo: ["chat": chat, "createdAt": createdAt, "from": from, "to": to])
        }
        
    }
    
    func establishConnection() {
        socket.connect()
    }
    
    func closeConnection() {
        socket.disconnect()
    }
    
}

