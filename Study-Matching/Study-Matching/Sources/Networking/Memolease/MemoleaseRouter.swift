import Foundation

enum MemoleaseRouter {
    
    case signup(phoneNumber: String, FCMToken: String, nick: String, birth: String, email: String, gender:Int)
    case signIn
    case updateToken
    
    static let headers: [String: String] = ["Content-Type" : "application/x-www-form-urlencoded"]
}

extension MemoleaseRouter {
    var path: String {
        let baseURL: String = "http://api.sesac.co.kr:1210"
        switch self {
        case .signup: return "\(baseURL)/v1/user"
        case .signIn: return "\(baseURL)/v1/user"
        case .updateToken: return "\(baseURL)/v1/user/update_fcm_token"
        }
    }
    var queryItems: [URLQueryItem]? {
        switch self {
        case .signup(let phoneNumber, let FCMToken, let nick, let birth, let email, let gender):
            
            return [URLQueryItem(name: "phoneNumber", value: phoneNumber),
                    URLQueryItem(name: "FCMtoken", value: FCMToken),
                    URLQueryItem(name: "nick", value: nick),
                    URLQueryItem(name: "birth", value: birth),
                    URLQueryItem(name: "email", value: email),
                    URLQueryItem(name: "gender", value: "\(gender)")]
        case .signIn:
            return nil
        case .updateToken:
            return [URLQueryItem(name: "idtoken", value: UserDefaultsManager.standard.idToken)]
        }
    }
    var httpMethod: HTTPMethod {
        switch self {
        case .signup: return .post
        case .signIn: return .get
        case .updateToken: return .put
        }
    }
    
    var headers: [String: String] {
        switch self {
        default:
            print("idtoken: -->  \(UserDefaultsManager.standard.idToken)")
            return ["Content-Type" : "application/x-www-form-urlencoded",
                    "idtoken" : UserDefaultsManager.standard.idToken]
            
        }
    }
}
