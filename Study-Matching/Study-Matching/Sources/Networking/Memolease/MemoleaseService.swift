import Foundation




class MemoleaseService {
    
    static let shared = MemoleaseService()
    
    private init() {}
    
    func requestSignup(path: String, queryItems: [URLQueryItem]?, httpMethod: HTTPMethod, headers: [String: String], completion: @escaping(Result<Succeess, MemoleaseError>) -> Void) {
        
        var urlComponents = URLComponents(string: path)
        urlComponents?.queryItems = queryItems
        print("\(path)🟩\(String(describing: urlComponents?.url))")
        
        
        
        
        var urlRequest = URLRequest(url: (urlComponents?.url)!)
        urlRequest.httpBody = urlComponents?.query?.data(using: .utf8)
        urlRequest.httpMethod = httpMethod.rawValue.uppercased()
        urlRequest.allHTTPHeaderFields = headers //헤더
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in

            
            DispatchQueue.main.async {
                guard let httpResponse = response as? HTTPURLResponse else { return }
                
                print("📭 Request \(urlRequest.url!)")
                print("🚩 Response \(httpResponse.statusCode)")
                
                
                switch httpResponse.statusCode {
                case 200:
                    completion(.success(.perfact)) //🚀 해당 vc 에서 처리
                case 201:
                    completion(.failure(.alreadyUser)) //🚀 해당 vc 에서 처리
                case 202:
                    completion(.failure(.nickError)) //🚀 해당 vc 에서 처리
                case 401:
                    completion(.failure(.idTokenError))
                    FirebaseService.shared.fetchIdToken { _ in }
                    print("♻️idtoken update 완료")
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
    
    func requestLogin(path: String, queryItems: [URLQueryItem]?, httpMethod: HTTPMethod, headers: [String: String], completion: @escaping(Result<MemoleaseUser, MemoleaseError>) -> Void) {
        
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
                    let user = try JSONDecoder().decode(//🚀 해당 vc 에서 처리
                        MemoleaseUser.self,
                        from: data)
                    
                    DispatchQueue.main.async {
                        completion(.success(user))
                    }
                }
                
                catch let decodingError {
                    print("⁉️ Failure", decodingError)
                    DispatchQueue.main.async {
                        completion(.failure(.decodingError))
                    }
                }
                
            case 401:
                completion(.failure(.idTokenError)) //🚀 해당 vc 에서 처리
                FirebaseService.shared.fetchIdToken { _ in }
                print("♻️idtoken update 완료")
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
            
            
        }.resume()
        
    }
    
    func updateFCMToken(path: String, queryItems: [URLQueryItem]?, httpMethod: HTTPMethod, headers: [String: String], completion: @escaping(Result<Succeess, MemoleaseError>) -> Void) {
        
        var urlComponents = URLComponents(string: path)
        urlComponents?.queryItems = queryItems
        print("\(path)🟩\(String(describing: urlComponents?.url))")
        
        var urlRequest = URLRequest(url: (urlComponents?.url)!)
        urlRequest.httpMethod = httpMethod.rawValue.uppercased()
        urlRequest.allHTTPHeaderFields = headers
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            
            guard let httpResponse = response as? HTTPURLResponse else { return }
            print("📭 Request \(urlRequest.url!)")
            print("🚩 Response \(httpResponse.statusCode)")
            
            switch httpResponse.statusCode {
            case 200:
                completion(.success(.perfact))//🚀 해당 vc 에서 처리
            case 401:
                completion(.failure(.idTokenError))
                FirebaseService.shared.fetchIdToken { _ in } //🚀 해당 vc 에서 처리
                print("♻️idtoken update 완료")
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
    
    func updateUserInfo(path: String, queryItems: [URLQueryItem]?, httpMethod: HTTPMethod, headers: [String: String], completion: @escaping(Result<Succeess, MemoleaseError>) -> Void) {
        
        var urlComponents = URLComponents(string: path)
        urlComponents?.queryItems = queryItems
        
        print("\(path)🟩\(String(describing: urlComponents?.url))")
        
        var urlRequest = URLRequest(url: (urlComponents?.url)!)
        urlRequest.httpBody = urlComponents?.query?.data(using: .utf8)
        urlRequest.httpMethod = httpMethod.rawValue.uppercased()
        urlRequest.allHTTPHeaderFields = headers
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            
            guard let httpResponse = response as? HTTPURLResponse else { return }
            print("📭 Request \(urlRequest.url!)")
            print("🚩 Response \(httpResponse.statusCode)")
            
            switch httpResponse.statusCode {
            case 200:
                completion(.success(.perfact)) //🚀 해당 vc 에서 처리
            case 401:
                completion(.failure(.idTokenError)) //🚀 해당 vc 에서 처리
                FirebaseService.shared.fetchIdToken { _ in }
                print("♻️idtoken update 완료")
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
    
    
    
    
    
    
    
    
}
