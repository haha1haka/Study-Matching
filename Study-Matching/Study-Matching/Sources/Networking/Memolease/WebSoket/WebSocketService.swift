//
//  WebSoketService.swift
//  Study-Matching
//
//  Created by HWAKSEONG KIM on 2022/12/04.
//

import Foundation

protocol socketEventDelegate: AnyObject {
    func chat(_ object: WebSocketService,_ item: String)
}

class WebSocketService: NSObject {
    
    static let shared = WebSocketService()
    
    private override init() {}
    
    weak var delegate: URLSessionWebSocketDelegate?
    var webSocketTask: URLSessionWebSocketTask?
    weak var eventDelegate: socketEventDelegate?
    
    
    var timer: Timer?
    
    func openWebSocket() throws {
        
        let session = URLSession(
            configuration: .default,
            delegate: self,
            delegateQueue: OperationQueue()
        )        
        let baseURL: String = "ws://api.sesac.co.kr:1210"
        
        guard let url = URL(string: baseURL) else { print("이건가"); return }
        
        webSocketTask = session.webSocketTask(with: url)
        
        webSocketTask?.resume()
        
        self.ping()
        
        receive()
    }
    

    func ping() {
        webSocketTask?.sendPing(pongReceiveHandler: { error in
            if let error = error {
                print("❌Ping error: \(error)")
            }
        })
    }
    
    func close() {
        webSocketTask?.cancel(with: .goingAway, reason: "ENEDED".data(using: .utf8))
    }
    
    func receive() {
        webSocketTask?.receive(completionHandler: {
            switch $0 {
            case .success(let message):
                switch message {
                case .data(let data):
                    print("Data: \(data)")
                case .string(let message):
                    self.eventDelegate?.chat(self, message)
                    print("Message: \(message)")
                default:
                    return
                }
                return
            case .failure(let error):
                dump(error  )
                return
            }
        })
    }
}

extension WebSocketService: URLSessionWebSocketDelegate {
    func urlSession(_ session: URLSession, webSocketTask: URLSessionWebSocketTask, didOpenWithProtocol protocol: String?) {
        self.delegate?.urlSession?(session, webSocketTask: webSocketTask, didOpenWithProtocol: `protocol` )
    }
    
    func urlSession(_ session: URLSession, webSocketTask: URLSessionWebSocketTask, didCloseWith closeCode: URLSessionWebSocketTask.CloseCode, reason: Data?) {
        self.delegate?.urlSession?(session, webSocketTask: webSocketTask, didCloseWith: closeCode, reason: reason)
    }
}
