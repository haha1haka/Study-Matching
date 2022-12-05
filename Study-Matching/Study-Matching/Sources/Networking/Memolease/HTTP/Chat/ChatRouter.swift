import Foundation

enum ChatRouter {

    case chat(id: String, chatText: String)
    case chatLast(id: String, lastchatDate: String)
}


extension ChatRouter: TargetType {

    
    var path: String {
        let baseURL: String = "http://api.sesac.co.kr:1210"
        switch self {
        case .chat(let id, _): return "\(baseURL)/v1/chat/\(id)"
        case .chatLast(let id, let lastchatDate): return "\(baseURL)/v1/chat/\(id)?lastchatDate=\(lastchatDate)"
        }
    }
    
    // MARK: - 헤더
    var headers: [String: String] {
        switch self {
        default:
            return ["Content-Type" : "application/x-www-form-urlencoded",
                    "idtoken"      : UserDefaultsManager.standard.idToken]
        }
    }
    
    // MARK: - 바디
    var parameters: String? {
        switch self {

        case .chat(_ ,let chatText):
            return ["chat": chatText].compactMap{ "\($0)=\($1)" }.joined(separator: "&")
        case .chatLast:
            return nil
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .chat    : return .post
        case .chatLast: return .get
        }
    }
    
    
    
}
