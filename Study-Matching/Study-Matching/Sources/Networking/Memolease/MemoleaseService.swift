import Foundation






class MemoleaseService: ResultType {
    
    static let shared = MemoleaseService()
    
    var session: URLSession {
        return URLSession.shared
    }
    
    private init() {}
    
    
    
    func requestGetUser(target: TargetType, completion: @escaping (Result<MemoleaseUser, MemoleaseError>) -> Void ){
        
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
                            self.updateFCMToken(target: UserRouter.FCMtoken(FCMtoken: fcmToken),
                                                completion: { print("🍀 FCMToken update 완료: \($0)") })
                        }
                        completion(.success(user))
                    }
                    
                    catch let decodingError {
                        print("⁉️ Failure", decodingError)
                        
                        completion(.failure(.decodingError))
                        
                    }
                    
                case 401:
                    FirebaseService.shared.fetchIdToken { _ in
                        completion(.failure(.idTokenError))
                    }
                     //🚀 해당 viewModel 에서 재귀로그인
                    
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
                    FirebaseService.shared.fetchIdToken { _ in
                        completion(.failure(.idTokenError))
                    } //🚀 해당 viewModel 에서 재귀로그인
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
                    self.updateFCMToken(target: UserRouter.FCMtoken(FCMtoken: fcmToken),
                                        completion: { print("🍀 FCMToken update 완료: \($0)") })
                    completion(.failure(.idTokenError)) //🚀 해당 viewModel 에서 재귀로그인
                }
                
                
                
                
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
        

        URLSession.shared.dataTask(with: target.request) { data, response, error in
            
            guard let httpResponse = response as? HTTPURLResponse else { return }
            print("📭 Request \(target.request.url!)")
            print("🚩 Response \(httpResponse.statusCode)")
            
            switch httpResponse.statusCode {
            case 200:
                completion(.success(.perfact)) //🚀 해당 vc 에서 처리
            case 401:
                FirebaseService.shared.fetchIdToken { _ in
                    completion(.failure(.idTokenError))
                } //🚀 해당 viewModel 에서 재귀로그인
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
    
    func requestWithdraw(target: TargetType, completion: @escaping MemoleaseResult) {
        

        
        session.dataTask(with: target.request) { data, response, error in
            
            
            DispatchQueue.main.async {
                guard let httpResponse = response as? HTTPURLResponse else { return }
                
                print("📭 Request \(target.request.url!)")
                print("🚩 Response \(httpResponse.statusCode)")
                
                
                switch httpResponse.statusCode {
                case 200:
                    completion(.success(.perfact)) //🚀 해당 vc 에서 처리: 온보딩 화면으로
                case 401:
                    FirebaseService.shared.fetchIdToken { _ in
                        completion(.failure(.idTokenError))
                    } //🚀 해당 viewModel 에서 재귀로그인
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
    
    func requestQueueSearch(
        target: TargetType,
        completion: @escaping (Result<Queue, MemoleaseError>) -> Void )
    {
        
        session.dataTask(with: target.request) { data, response, error in
            DispatchQueue.main.async {
                guard let httpResponse = response as? HTTPURLResponse else { return }
                print("📭 Request \(target.request.url!)")
                print("🚩 Response 너지범인 \(httpResponse.statusCode)")
                
                guard let data = data else { print("데이터 없음"); return }
                
                switch httpResponse.statusCode {
                case 200:
                    
                    do {
                        let queueSearch = try JSONDecoder().decode( //🚀 해당 vc 에서 처리
                            Queue.self,
                            from: data)
                        
                        
                        dump("🐙🐙🐙\(queueSearch)")
                        completion(.success(queueSearch))
                        return
                    }
                    catch let decodingError {
                        print("⁉️ Failure", decodingError)
                        
                        completion(.failure(.decodingError))
                        return
                    }
                    
                case 401:
                    FirebaseService.shared.fetchIdToken { _ in
                        completion(.failure(.idTokenError))
                    } //🚀 해당 viewModel 에서 재귀로그인
                    
                    return
                case 406:
                    completion(.failure(.unRegistedUser)) //🚀 해당 vc 에서 처리: 화면이동
                    return
                case 500:
                    completion(.failure(.serverError))
                    print("❌500")
                    return
                case 501:
                    completion(.failure(.clientError))
                    print("❌501")
                    return
                default:
                    completion(.failure(.unknown))
                    return
                }
            }
            
        }.resume()
        
    }
    
    func requestGetQueue(target: TargetType, completion: @escaping MemoleaseResult) {
        
        session.dataTask(with: target.request) { data, response, error in
            
            DispatchQueue.main.async {
                guard let httpResponse = response as? HTTPURLResponse else { return }
                print("📭 Request \(target.request.url!)")
                print("🚩 Response \(httpResponse.statusCode)")
                
                switch httpResponse.statusCode {
                case 200:
                    completion(.success(.perfact)) //🚀 해당 vc 에서 처리
                case 201:
                    completion(.failure(.unavailable))
                case 203:
                    completion(.failure(.penalty1))
                case 204:
                    completion(.failure(.penalty2))
                case 205:
                    completion(.failure(.penalty3))
                case 401:
                    FirebaseService.shared.fetchIdToken { _ in
                        completion(.failure(.idTokenError))
                    }
                case 406:
                    completion(.failure(.unRegistedUser))
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
    
    
    
    func requestQueueStop(target: TargetType, completion: @escaping MemoleaseResult) {
        

        
        session.dataTask(with: target.request) { data, response, error in
            
            
            DispatchQueue.main.async {
                guard let httpResponse = response as? HTTPURLResponse else { return }
                
                print("📭 Request \(target.request.url!)")
                print("🚩 Response \(httpResponse.statusCode)")
                
                
                switch httpResponse.statusCode {
                case 200:
                    completion(.success(.perfact)) //🚀 해당 vc 에서 처리: 온보딩 화면으로
                case 401:
                    FirebaseService.shared.fetchIdToken { _ in
                        completion(.failure(.idTokenError))
                    } //🚀 해당 viewModel 에서 재귀로그인
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
    
    func requestQueueState( target: TargetType, completion: @escaping (Result<QueueState?, MemoleaseError>) -> Void )
    {
        
        session.dataTask(with: target.request) { data, response, error in
            DispatchQueue.main.async {
                guard let httpResponse = response as? HTTPURLResponse else { return }
                print("📭 Request \(target.request.url!)")
                print("🚩 Response \(httpResponse.statusCode)")
                
                guard let data = data else { print("데이터 없음"); return }
                
                switch httpResponse.statusCode {
                case 200:
                    do {
                        let state = try JSONDecoder().decode(//🚀 해당 vc 에서 처리
                            QueueState.self,
                            from: data)
                        
                        UserDefaultsManager.standard.matchedState = state.matched
                                                
                        completion(.success(state))
                    }
                    
                    catch let decodingError {
                        print("⁉️ Failure", decodingError)
                        
                        completion(.failure(.decodingError))
                        
                    }
                case 201:
                    UserDefaultsManager.standard.matchedState = 2
                    completion(.failure(.defaultState))
                case 401:
                    FirebaseService.shared.fetchIdToken { _ in
                        completion(.failure(.idTokenError))
                    }
                case 406: completion(.failure(.unRegistedUser)) //🚀 해당 vc 에서 처리
                case 500: completion(.failure(.serverError))
                    print("❌500")
                case 501: completion(.failure(.clientError))
                    print("❌501")
                default: completion(.failure(.unknown))
                }
                
            }
        }.resume()
        
    }

    func requestStudy(target: TargetType, completion: @escaping MemoleaseResult) {
                
        session.dataTask(with: target.request) { data, response, error in
            
            
            DispatchQueue.main.async {
                
                guard let httpResponse = response as? HTTPURLResponse else { return }
                
                print("📭 Request \(target.request.url!)")
                print("🚩 Response \(httpResponse.statusCode)")
                
                
                switch httpResponse.statusCode {
                case 200:
                    completion(.success(.perfact))
                case 201:
                    completion(.success(.alreadyRequested))
                case 202:
                    completion(.failure(.searchStop)) //🚀 해당 vc 에서 처리
                case 401:
                    FirebaseService.shared.fetchIdToken { _ in
                        completion(.failure(.idTokenError))
                    }
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
    
    func requestAccept(target: TargetType, completion: @escaping MemoleaseResult) {
                
        session.dataTask(with: target.request) { data, response, error in
            
            
            DispatchQueue.main.async {
                
                guard let httpResponse = response as? HTTPURLResponse else { return }
                
                print("📭 Request \(target.request.url!)")
                print("🚩 Response \(httpResponse.statusCode)")
                
                
                switch httpResponse.statusCode {
                case 200:
                    completion(.success(.perfact))
                case 201:
                    completion(.success(.alreadyMatching))
                case 202:
                    completion(.success(.searchStoping))
                case 203:
                    completion(.success(.someoneWhoLikesMe))
                case 401:
                    FirebaseService.shared.fetchIdToken { _ in
                        completion(.failure(.idTokenError))
                    }
                case 406:
                    completion(.failure(.unRegistedUser))
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
    
    func requestPostChat(target: TargetType, completion: @escaping (Result<Chat, MemoleaseError>) -> Void ) {
        
        session.dataTask(with: target.request) { data, response, error in
            DispatchQueue.main.async {
                guard let httpResponse = response as? HTTPURLResponse else { return }
                print("📭 Request \(target.request.url!)")
                print("🚩 Response \(httpResponse.statusCode)")
                
                guard let data = data else { print("데이터 없음"); return }
                
                switch httpResponse.statusCode {
                case 200:
                    do {
                        let chat = try JSONDecoder().decode(//🚀 해당 vc 에서 처리
                            Chat.self,
                            from: data)
                        
                        completion(.success(chat))
                    }
                    
                    catch let decodingError {
                        print("⁉️ Failure", decodingError)
                        
                        completion(.failure(.decodingError))
                        
                    }
                case 201:
                    completion(.failure(.unavailable))
                case 401:
                    FirebaseService.shared.fetchIdToken { _ in
                        completion(.failure(.idTokenError))
                    }
                case 406:
                    completion(.failure(.unRegistedUser))
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

    
    
    func requestGetLastChat(target: TargetType, completion: @escaping (Result<ChatLast, MemoleaseError>) -> Void ){
        
        session.dataTask(with: target.request) { data, response, error in
            DispatchQueue.main.async {
                guard let httpResponse = response as? HTTPURLResponse else { return }
                print("📭 Request \(target.request.url!)")
                print("🚩 Response \(httpResponse.statusCode)")
                
                guard let data = data else { print("데이터 없음"); return }
                
                switch httpResponse.statusCode {
                case 200:
                    do {
                        let lastChat = try JSONDecoder().decode(
                            ChatLast.self,
                            from: data)
                        completion(.success(lastChat))
                    }
                    
                    catch let decodingError {
                        print("⁉️ Failure", decodingError)
                        
                        completion(.failure(.decodingError))
                        
                    }
                    
                case 401:
                    FirebaseService.shared.fetchIdToken { _ in
                        completion(.failure(.idTokenError))
                    }
                     
                    
                case 406:
                    completion(.failure(.unRegistedUser)) 
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

    
    
    
}
