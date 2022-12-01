import Foundation

enum UserRouter {
    case signIn
    case signup(phoneNumber: String, FCMtoken: String, nick: String, birth: String, email: String, gender:Int)
    case FCMtoken(FCMtoken: String)
    case updateUser(searchable: Int, ageMin: Int, ageMax: Int, gender: Int, study: String)
    case withdraw
}


extension UserRouter: TargetType {

    var path: String {
        let baseURL: String = "http://api.sesac.co.kr:1210"
        switch self {
        case .signIn:      return "\(baseURL)/v1/user"
        case .signup:      return "\(baseURL)/v1/user"
        case .FCMtoken:    return "\(baseURL)/v1/user/update_fcm_token"
        case .updateUser:  return "\(baseURL)/v1/user/mypage"
        case .withdraw:    return "\(baseURL)/v1/user/withdraw"

        }
    }
    
    // MARK: - 헤더
    var headers: [String: String] {
        switch self {
        default:
            print("idtoken : \(UserDefaultsManager.standard.idToken)")
            return ["Content-Type" : "application/x-www-form-urlencoded",
                    "idtoken"      : UserDefaultsManager.standard.idToken]
        }
    }

    // MARK: - 바디
    var parameters: String? {
        switch self {
            
        case .signIn:
            return nil
            
        case .signup(let phoneNumber, let FCMtoken, let nick, let birth, let email, let gender):
            return  ["phoneNumber": "\(phoneNumber)",
                     "FCMtoken": "\(FCMtoken)",
                     "nick": "\(nick)",
                     "birth": "\(birth)",
                     "email": "\(email)",
                     "gender": "\(gender)"].compactMap{ "\($0)=\($1)" }.joined(separator: "&")
            
            
        case .FCMtoken(let FCMtoken):
            return ["FCMtoken": "\(FCMtoken)"].compactMap{ "\($0)=\($1)" }.joined(separator: "&")
            
        case .updateUser(let searchable, let ageMin, let ageMax, let gender, let study):
            return ["searchable": "\(searchable)",
                    "ageMin": "\(ageMin)",
                    "ageMax": "\(ageMax)",
                    "gender": "\(gender)",
                    "study": "\(study)"].compactMap{ "\($0)=\($1)" }.joined(separator: "&")
            
                
        case .withdraw:
            return nil
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .signIn        : return .get
        case .signup        : return .post
        case .FCMtoken      : return .put
        case .updateUser    : return .put
        case .withdraw      : return .post
        }
    }
    
    
    
}
