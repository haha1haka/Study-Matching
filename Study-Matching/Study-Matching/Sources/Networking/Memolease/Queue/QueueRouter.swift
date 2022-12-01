import Foundation

enum QueueRouter {

    case queueSearch(lat: Double, long: Double)
    case queue(lat: Double, long: Double, studylist: [String])
    case queueStop
    case queueState
    case queueRequest(otheruid: String)
    
}


extension QueueRouter: TargetType {

    
    var path: String {
        let baseURL: String = "http://api.sesac.co.kr:1210"
        switch self {
        case .queueSearch:  return "\(baseURL)/v1/queue/search"
        case .queue:        return "\(baseURL)/v1/queue"
        case .queueStop:    return "\(baseURL)/v1/queue"
        case .queueState:   return "\(baseURL)/v1/queue/myQueueState"
        case .queueRequest: return "\(baseURL)/v1/queue/studyrequest"
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
    //((parameters?.compactMap({key, value in return "\(key)=\(value)"}))! as Array).joined(separator: "&").data(using: .utf8)
    // MARK: - 바디
    var parameters: String? {
        switch self {
            
        case .queueSearch(let lat, let long):
            return ["lat": "\(lat)",
                    "long": "\(long)"].compactMap{ "\($0)=\($1)" }.joined(separator: "&")
                        
        case .queue(let lat, let long, let studylist):
            var parameters = ["lat": "\(lat)",
                              "long": "\(long)"].compactMap{ "\($0)=\($1)" }.joined(separator: "&")
            
            studylist.forEach{
                parameters += "&studylist=\($0)"
            }
            
            return parameters
                
            
        case .queueStop:
            return nil
            
        case .queueState:
            return nil
            
        case .queueRequest(let otheruid):
            return ["otheruid": otheruid].compactMap{ "\($0)=\($1)" }.joined(separator: "&")
            
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {

        case .queueSearch   : return .post
        case .queue         : return .post
        case .queueStop     : return .delete
        case .queueState    : return .get
        case .queueRequest  : return .post
        }
    }
    
    
    
}
