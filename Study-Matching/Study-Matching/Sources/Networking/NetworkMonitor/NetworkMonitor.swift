import Foundation
import Network

class NetworkMonitor {
    
    static let shared = NetworkMonitor()
    
    func startMonitoring(completion: @escaping (String) -> Void) {
        let monitor = NWPathMonitor()
        
        monitor.pathUpdateHandler = {
            path in
            
            if path.status == .satisfied {
                DispatchQueue.main.async {
                    return
                }
            } else {
                DispatchQueue.main.async {
                    completion("네트워크 연결 불안정 합니다")
                }
            }
        }
        let queue = DispatchQueue(label: "monitor")
        monitor.start(queue: queue)
    }

}

