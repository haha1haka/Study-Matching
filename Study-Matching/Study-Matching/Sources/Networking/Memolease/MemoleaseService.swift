import Foundation


//extension HTTPURLResponse: ResultType {
//    var divide: MemoleaseResult {
//        switch self.statusCode {
//            
//        default:
//            <#code#>
//        }
//    }
//    
//}


class MemoleaseService: ResultType {
    
    static let shared = MemoleaseService()
    
    var session: URLSession {
        return URLSession.shared
    }
    
    private init() {}
   
    func requestGetUser(target: TargetType, completion: @escaping MemoleaseUserGetResult ) {
        

        
        
        session.dataTask(with: target.request) { data, response, error in
            DispatchQueue.main.async {
                guard let httpResponse = response as? HTTPURLResponse else { return }
                print("📭 Request \(target.request.url!)")
                print("🚩 Response \(httpResponse.statusCode)")
                
                guard let data = data else { print("데이터 없음"); return }
                
                switch httpResponse.statusCode {
                case 200:
                    do {
                        let user = try JSONDecoder().decode(//🚀 해당 vc 에서 처리
                            MemoleaseUser.self,
                            from: data)
                        
                        let fcmToken = UserDefaultsManager.standard.FCMToken
                        
                        if user.fcMtoken != fcmToken {
                            self.updateFCMToken(target: MemoleaseRouter.FCMtoken(FCMtoken: fcmToken),
                                                completion: { print("🍀 FCMToken update 완료: \($0)") })
                        }
                        completion(.success(user))
                    }
                    
                    catch let decodingError {
                        print("⁉️ Failure", decodingError)
                        
                        completion(.failure(.decodingError))
                        
                    }
                    
                case 401:
                    FirebaseService.shared.fetchIdToken { _ in }
                    completion(.failure(.idTokenError)) //🚀 해당 viewModel 에서 재귀로그인
                    
                case 406:
                    completion(.failure(.unRegistedUser)) //🚀 해당 vc 에서 처리
                case 500:
                    completion(.failure(.serverError))
                    print("❌500")
                case 501:
                    completion(.failure(.clientError))
                    print("❌501")
                default:
                    completion(.failure(.unknown))
                }
                
            }
        }.resume()
        
    }
    
    func requestSignup(target: TargetType, completion: @escaping MemoleaseResult) {
        
        //        var urlComponents = URLComponents(string: path)
        //        urlComponents?.queryItems = queryItems
        //        print("\(path)🟩\(String(describing: urlComponents?.url))")
        //
        //
        //        var urlRequest = URLRequest(url: (urlComponents?.url)!)
        //        urlRequest.httpBody = urlComponents?.query?.data(using: .utf8)
        //        urlRequest.httpMethod = httpMethod.rawValue.uppercased()
        //        urlRequest.allHTTPHeaderFields = headers //헤더
        
        session.dataTask(with: target.request) { data, response, error in
            
            
            DispatchQueue.main.async {
                guard let httpResponse = response as? HTTPURLResponse else { return }
                
                print("📭 Request \(target.request.url!)")
                print("🚩 Response \(httpResponse.statusCode)")
                
                
                switch httpResponse.statusCode {
                case 200:
                    completion(.success(.perfact)) //🚀 해당 vc 에서 처리
                case 201:
                    completion(.failure(.alreadyUser)) //🚀 해당 vc 에서 처리
                case 202:
                    completion(.failure(.nickError)) //🚀 해당 vc 에서 처리
                case 401:
                    FirebaseService.shared.fetchIdToken{ _ in }
                    completion(.failure(.idTokenError)) //🚀 해당 viewModel 에서 재귀로그인
                case 500:
                    completion(.failure(.serverError))
                    print("❌500 왜?")
                case 501:
                    completion(.failure(.clientError))
                    print("❌501")
                default:
                    completion(.failure(.unknown))
                    print("❌unknown")
                }
                
            }
            
            
        }.resume()
        
    }
    
    
    func updateFCMToken(target: TargetType, completion: @escaping MemoleaseResult) {
        
        //        var urlComponents = URLComponents(string: path)
        //        urlComponents?.queryItems = queryItems
        //        print("\(path)🟩\(String(describing: urlComponents?.url))")
        //
        //        var urlRequest = URLRequest(url: (urlComponents?.url)!)
        //        urlRequest.httpMethod = httpMethod.rawValue.uppercased()
        //        urlRequest.allHTTPHeaderFields = headers
        
        session.dataTask(with: target.request) { data, response, error in
            
            guard let httpResponse = response as? HTTPURLResponse else { return }
            print("📭 Request \(target.request.url!)")
            print("🚩 Response \(httpResponse.statusCode)")
            
            switch httpResponse.statusCode {
            case 200:
                completion(.success(.perfact))//🚀 해당 vc 에서 처리
            case 401:
                
                FirebaseService.shared.fetchIdToken { _ in
                    let fcmToken = UserDefaultsManager.standard.FCMToken
                    self.updateFCMToken(target: MemoleaseRouter.FCMtoken(FCMtoken: fcmToken),
                                        completion: { print("🍀 FCMToken update 완료: \($0)") })
                }
                
                    
                
                completion(.failure(.idTokenError)) //🚀 해당 viewModel 에서 재귀로그인
            case 406:
                completion(.failure(.unRegistedUser)) //🚀 해당 vc 에서 처리
            case 500:
                completion(.failure(.serverError))
                print("❌500")
            case 501:
                completion(.failure(.clientError))
                print("❌501")
            default:
                completion(.failure(.unknown))
                print("❌unknown")
            }
            
            
        }.resume()
    }
    
    func updateUser(target: TargetType, completion: @escaping MemoleaseResult) {
        
//        var urlComponents = URLComponents(string: path)
//        urlComponents?.queryItems = queryItems
//
//        print("\(path)🟩\(String(describing: urlComponents?.url))")
//
//        var urlRequest = URLRequest(url: (urlComponents?.url)!)
//        urlRequest.httpBody = urlComponents?.query?.data(using: .utf8)
//        urlRequest.httpMethod = httpMethod.rawValue.uppercased()
//        urlRequest.allHTTPHeaderFields = headers
        
        URLSession.shared.dataTask(with: target.request) { data, response, error in
            
            guard let httpResponse = response as? HTTPURLResponse else { return }
            print("📭 Request \(target.request.url!)")
            print("🚩 Response \(httpResponse.statusCode)")
            
            switch httpResponse.statusCode {
            case 200:
                completion(.success(.perfact)) //🚀 해당 vc 에서 처리
            case 401:
                FirebaseService.shared.fetchIdToken { _ in }
                completion(.failure(.idTokenError)) //🚀 해당 viewModel 에서 재귀로그인
                
            case 406:
                completion(.failure(.unRegistedUser)) //🚀 해당 vc 에서 처리
            case 500:
                completion(.failure(.serverError))
                print("❌500")
            case 501:
                completion(.failure(.clientError))
                print("❌501")
            default:
                completion(.failure(.unknown))
                print("❌unknown")
            }
            
            
        }.resume()
    }
    
    func requestWithdraw(path: String, queryItems: [URLQueryItem]?, httpMethod: HTTPMethod, headers: [String: String], completion: @escaping MemoleaseResult) {
        
        var urlComponents = URLComponents(string: path)
        urlComponents?.queryItems = queryItems
        print("\(path)🟩\(String(describing: urlComponents?.url))")
        
        
        var urlRequest = URLRequest(url: (urlComponents?.url)!)
        urlRequest.httpBody = urlComponents?.query?.data(using: .utf8)
        urlRequest.httpMethod = httpMethod.rawValue.uppercased()
        urlRequest.allHTTPHeaderFields = headers
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            
            
            DispatchQueue.main.async {
                guard let httpResponse = response as? HTTPURLResponse else { return }
                
                print("📭 Request \(urlRequest.url!)")
                print("🚩 Response \(httpResponse.statusCode)")
                
                
                switch httpResponse.statusCode {
                case 200:
                    completion(.success(.perfact)) //🚀 해당 vc 에서 처리: 온보딩 화면으로
                case 401:
                    FirebaseService.shared.fetchIdToken { _ in }
                    completion(.failure(.idTokenError))
                case 406: //🚀 해당 vc 에서 처리: 온보딩 화면으로
                    completion(.failure(.aleadyWithdraw))
                case 500:
                    completion(.failure(.serverError))
                    print("❌500")
                case 501:
                    completion(.failure(.clientError))
                    print("❌501")
                default:
                    completion(.failure(.unknown))
                    print("❌unknown")
                }
                
            }
            
            
        }.resume()
        
        
    }
    
    func requestQueue(path: String, queryItems: [URLQueryItem]?, httpMethod: HTTPMethod, headers: [String: String], completion: @escaping MemoleaseQueueSearchPostResult ) {
        
        var urlComponents = URLComponents(string: path)
        urlComponents?.queryItems = queryItems
        print("\(path)🟩\(String(describing: urlComponents?.url))")
        
        
        
        var urlRequest = URLRequest(url: (urlComponents?.url)!)
        urlRequest.httpBody = urlComponents?.query?.data(using: .utf8)
        urlRequest.httpMethod = httpMethod.rawValue.uppercased()
        urlRequest.allHTTPHeaderFields = headers //헤더
        
        
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            
            guard let httpResponse = response as? HTTPURLResponse else { return }
            print("📭 Request \(urlRequest.url!)")
            print("🚩 Response \(httpResponse.statusCode)")
            
            guard let data = data else { print("데이터 없음"); return }
            
            switch httpResponse.statusCode {
            case 200:
                
                do {
                    let queueSearch = try JSONDecoder().decode( //🚀 해당 vc 에서 처리
                        MemoleaseQueue.self,
                        from: data)
                    
                    DispatchQueue.main.async {
                        print("🐙🐙🐙\(queueSearch)")
                        completion(.success(queueSearch))
                    }
                }
                catch let decodingError {
                    print("⁉️ Failure", decodingError)
                    DispatchQueue.main.async {
                        completion(.failure(.decodingError))
                    }
                }
                
            case 401:
                FirebaseService.shared.fetchIdToken { _ in }
                print("♻️idtoken update 완료")
                completion(.failure(.idTokenError)) //🚀 해당 viewModel 에서 재귀로그인
            case 406:
                completion(.failure(.unRegistedUser)) //🚀 해당 vc 에서 처리: 화면이동
            case 500:
                completion(.failure(.serverError))
                print("❌500")
            case 501:
                completion(.failure(.clientError))
                print("❌501")
            default:
                completion(.failure(.unknown))
            }
            
            
        }.resume()
        
    }
    
    
    
}
