import Foundation

enum MemoleaseRouter {
    
    case signIn
    case signup(phoneNumber: String, FCMtoken: String, nick: String, birth: String, email: String, gender:Int)
    case FCMtoken(FCMtoken: String)
    case updateUser(searchable: Int, ageMin: Int, ageMax: Int, gender: Int, study: String)
    case withdraw
    case queue(lat: Double, long: Double)
    
}


extension MemoleaseRouter: TargetType {


    var path: String {
        let baseURL: String = "http://api.sesac.co.kr:1210"
        switch self {
        case .signIn:         return "\(baseURL)/v1/user"
        case .signup:         return "\(baseURL)/v1/user"
        case .FCMtoken:       return "\(baseURL)/v1/user/update_fcm_token"
        case .updateUser:           return "\(baseURL)/v1/user/mypage"
        case .withdraw:       return "\(baseURL)/v1/user/withdraw"
        case .queue:          return "\(baseURL)/v1/queue/search"
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
            
        case .signIn:
            return nil
            
        case .signup(let phoneNumber, let FCMtoken, let nick, let birth, let email, let gender):
            return [URLQueryItem(name: "phoneNumber", value: phoneNumber),
                    URLQueryItem(name: "FCMtoken",    value: FCMtoken),
                    URLQueryItem(name: "nick",        value: nick),
                    URLQueryItem(name: "birth",       value: birth),
                    URLQueryItem(name: "email",       value: email),
                    URLQueryItem(name: "gender",      value: "\(gender)")]
            
        case .FCMtoken(let FCMtoken):
            return [URLQueryItem(name: "FCMtoken",   value: FCMtoken)]
            
        case .updateUser(let searchable, let ageMin, let ageMax, let gender, let study):
            return [URLQueryItem(name: "searchable", value: "\(searchable)"),
                    URLQueryItem(name: "ageMin",     value: "\(ageMin)"),
                    URLQueryItem(name: "ageMax",     value: "\(ageMax)"),
                    URLQueryItem(name: "gender",     value: "\(gender)"),
                    URLQueryItem(name: "study",      value: study)]
            
        case .withdraw:
            return nil
            
        case .queue(let lat, let long):
            return [URLQueryItem(name: "lat", value: "\(lat)"),
                    URLQueryItem(name: "long", value: "\(long)")]
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .signIn        : return .get
        case .signup        : return .post
        case .FCMtoken   : return .put
        case .updateUser: return .put
        case .withdraw      : return .post
        case .queue   : return .post
        }
    }
    
    

}
