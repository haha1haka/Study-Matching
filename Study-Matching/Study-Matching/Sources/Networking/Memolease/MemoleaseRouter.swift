import Foundation

enum MemoleaseRouter {
    
    case signup(phoneNumber: String, FCMToken: String, nick: String, birth: String, email: String, gender:Int)
    
    static let baseURL: String = "http://api.sesac.co.kr:1207"
    static let headers: [String: String] = ["Content-Type" : "application/x-www-form-urlencoded"]
}

extension MemoleaseRouter {
    var path: String {
        switch self {
        case .signup: return "/v1/user"
        }
    }
    var queryItems: [URLQueryItem] {
        switch self {
        case .signup(let phoneNumber, let FCMToken, let nick, let birth, let email, let gender):
            
            return [URLQueryItem(name: "phoneNumber", value: phoneNumber),
                    URLQueryItem(name: "FCMToken", value: FCMToken),
                    URLQueryItem(name: "nick", value: nick),
                    URLQueryItem(name: "birth", value: birth),
                    URLQueryItem(name: "email", value: email),
                    URLQueryItem(name: "gender", value: "\(gender)")]
        }
    }
    var httpMethod: HTTPMethod {
        switch self {
        case .signup: return .post
        }
    }
    
    var headers: [String: String] {
        switch self {
        default:
            return ["Content-Type" : "application/x-www-form-urlencoded",
                    "idtoken" : UserDefaultsManager.standard.idToken]
            
        }
    }
}
