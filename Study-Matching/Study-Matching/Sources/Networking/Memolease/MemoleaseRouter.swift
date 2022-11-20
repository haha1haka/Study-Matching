import Foundation

enum MemoleaseRouter {
    
    case signup(phoneNumber: String, FCMtoken: String, nick: String, birth: String, email: String, gender:Int)
    case signIn
    case updateToken(FCMtoken: String)
    case updateUserInfo(searchable: Int, ageMin: Int, ageMax: Int, gender: Int, study: String)
    case withdraw
    
}

extension MemoleaseRouter {
    
    var path: String {
        let baseURL: String = "http://api.sesac.co.kr:1210"
        switch self {
        case .signup:         return "\(baseURL)/v1/user"
        case .signIn:         return "\(baseURL)/v1/user"
        case .updateToken:    return "\(baseURL)/v1/user/update_fcm_token"
        case .updateUserInfo: return "\(baseURL)/v1/user/mypage"
        case .withdraw:       return "\(baseURL)/v1/user/withdraw"
        }
    }
    
    // MARK: - 헤더
    var headers: [String: String] {
        switch self {
        default:
            print("idtoken         : \(UserDefaultsManager.standard.idToken)")
            return ["Content-Type" : "application/x-www-form-urlencoded",
                    "idtoken"      : UserDefaultsManager.standard.idToken]
        }
    }

    // MARK: - 바디
    var queryItems: [URLQueryItem]? {
        switch self {
            
        case .signup(let phoneNumber, let FCMtoken, let nick, let birth, let email, let gender):
            return [URLQueryItem(name: "phoneNumber", value: phoneNumber),
                    URLQueryItem(name: "FCMtoken",    value: FCMtoken),
                    URLQueryItem(name: "nick",        value: nick),
                    URLQueryItem(name: "birth",       value: birth),
                    URLQueryItem(name: "email",       value: email),
                    URLQueryItem(name: "gender",      value: "\(gender)")]
            
        case .signIn:
            return nil
            
        case .updateToken(let FCMtoken):
            return [URLQueryItem(name: "FCMtoken",   value: FCMtoken)]
            
        case .updateUserInfo(let searchable, let ageMin, let ageMax, let gender, let study):
            return [URLQueryItem(name: "searchable", value: "\(searchable)"),
                    URLQueryItem(name: "ageMin",     value: "\(ageMin)"),
                    URLQueryItem(name: "ageMax",     value: "\(ageMax)"),
                    URLQueryItem(name: "gender",     value: "\(gender)"),
                    URLQueryItem(name: "study",      value: study)]
            
        case .withdraw:
            return nil
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .signup        : return .post
        case .signIn        : return .get
        case .updateToken   : return .put
        case .updateUserInfo: return .put
        case .withdraw      : return .post
        }
    }

}
