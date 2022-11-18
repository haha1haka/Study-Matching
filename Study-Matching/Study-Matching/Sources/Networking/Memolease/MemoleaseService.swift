import Foundation




class MemoleaseService {
    
    static let shared = MemoleaseService()
    
    private init() {}
    
    func requestSignup(path: String, queryItems: [URLQueryItem]?, httpMethod: HTTPMethod, headers: [String: String], completion: @escaping(Result<Succeess, MemoleaseError>) -> Void) {
        
        var urlComponents = URLComponents(string: path)
        
        //print("\(path)🟩\(urlComponents?.url)")
        
        urlComponents?.queryItems = queryItems
        
        var urlRequest = URLRequest(url: (urlComponents?.url)!)
        urlRequest.httpBody = urlComponents?.query?.data(using: .utf8) //바디
        urlRequest.httpMethod = httpMethod.rawValue.uppercased()
        urlRequest.allHTTPHeaderFields = headers //헤더
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            
            
            //if let data = data {
            //    print("🌟\(data.description)")
            //} else {
            //    print("\(error?.localizedDescription)")
            //}
            
            DispatchQueue.main.async {
                guard let httpResponse = response as? HTTPURLResponse else { return }
                
                print("📭 Request \(urlRequest.url!)")
                print("🚩 Response \(httpResponse.statusCode)")
                
                
                switch httpResponse.statusCode {
                case 200:
                    completion(.success(.perfact))
                case 201:
                    completion(.failure(.alreadyUser))
                case 202:
                    completion(.failure(.nickError))
                case 401:
                    completion(.failure(.firebaseTokenError))
                case 500:
                    completion(.failure(.serverError))
                case 501:
                    completion(.failure(.clientError))
                default:
                    completion(.failure(.unknown))
                }
                
            }
            
            
        }.resume()
        
    }
    
    func requestUserInfo(path: String, queryItems: [URLQueryItem]?, httpMethod: HTTPMethod, headers: [String: String], completion: @escaping(Result<MemoleaseUser, MemoleaseError>) -> Void) {
        
        var urlComponents = URLComponents(string: path)
        
        print("\(path)🟩\(urlComponents?.url)")
        
        urlComponents?.queryItems = queryItems
        
        var urlRequest = URLRequest(url: (urlComponents?.url)!)
        urlRequest.httpBody = urlComponents?.query?.data(using: .utf8) //바디
        urlRequest.httpMethod = httpMethod.rawValue.uppercased()
        urlRequest.allHTTPHeaderFields = headers //헤더

        
        
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            
            guard let httpResponse = response as? HTTPURLResponse else { return }
            print("📭 Request \(urlRequest.url!)")
            print("🚩 Response \(httpResponse.statusCode)")
            
            guard let data = data else { print("데이터 없음"); return }
            do {
                let user = try JSONDecoder().decode(MemoleaseUser.self, from: data)
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
            
            switch httpResponse.statusCode {
            case 401:
                completion(.failure(.firebaseTokenError))
            case 406:
                completion(.failure(.unRegistedUser))
            case 500:
                completion(.failure(.serverError))
            case 501:
                completion(.failure(.clientError))
            default:
                completion(.failure(.unknown))
            }
    
            
        }.resume()
        
    }
    
    func updateFCMToken(path: String, queryItems: [URLQueryItem]?, httpMethod: HTTPMethod, headers: [String: String], completion: @escaping(Result<Succeess, MemoleaseError>) -> Void) {
        
        var urlComponents = URLComponents(string: path)
        urlComponents?.queryItems = queryItems
        
        var urlRequest = URLRequest(url: (urlComponents?.url)!)
        urlRequest.httpMethod = httpMethod.rawValue.uppercased()
        urlRequest.allHTTPHeaderFields = headers

        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            
            guard let httpResponse = response as? HTTPURLResponse else { return }
            print("📭 Request \(urlRequest.url!)")
            print("🚩 Response \(httpResponse.statusCode)")
                        
            switch httpResponse.statusCode {
            case 200:
                completion(.success(.perfact))
            case 401:
                completion(.failure(.firebaseTokenError))
            case 406:
                completion(.failure(.unRegistedUser))
            case 500:
                completion(.failure(.serverError))
            case 501:
                completion(.failure(.clientError))
            default:
                completion(.failure(.unknown))
            }
    
            
        }.resume()
    }
    
    
    
    
    //    func requestTopics(onSuccess: @escaping (([USTopic]) -> Void), onFailure: @escaping ((USError) -> Void)) {
    //        var urlComponents = URLComponents(string: UnsplashEndPoint.baseURL)
    //        urlComponents?.path = UnsplashEndPoint.topics.path
    //        urlComponents?.queryItems = [
    //            URLQueryItem(name: "order_by", value: "featured")
    //        ]
    //
    //        guard let url = urlComponents?.url else { return }
    //
    //        //print(url)
    //
    //        var urlRequest = URLRequest(url: url)
    //
    //        urlRequest.httpMethod = HTTPMethod.get.rawValue.uppercased()
    //
    //        urlRequest.allHTTPHeaderFields = UnsplashService.headers
    //
    //        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
    //
    //            guard let httpResponse = response as? HTTPURLResponse else { return }
    //            print("📭 Request \(urlRequest.url!)")
    //            print("🚩 Response \(httpResponse.statusCode)")
    //
    //            if let data = data {
    //
    //                if (200...299).contains(httpResponse.statusCode) {
    //                    print("✅ Success", data)
    //                    do {
    //                        let topics = try JSONDecoder().decode([USTopic].self, from: data)
    //                        DispatchQueue.main.async {
    //                            onSuccess(topics)
    //                        }
    //                    }
    //                    catch let decodingError {
    //                        print("⁉️ Failure", decodingError)
    //                        DispatchQueue.main.async {
    //                            onFailure(.decodingError)
    //                        }
    //                    }
    //                }
    //                else {
    //                    print("❌ Failure", String(data: data, encoding: .utf8)!)
    //                }
    //
    //            }
    //
    //            if let error = error {
    //                print("❌ Failure (Internal)", error.localizedDescription)
    //                DispatchQueue.main.async {
    //                    onFailure(USError(errors: [error.localizedDescription]))
    //                }
    //                return
    //            }
    //
    //        }.resume()
    //
    //    }
    
    func requestUserMainDTO(path: String, queryItems: [URLQueryItem]?, httpMethod: HTTPMethod, headers: [String: String], completion: @escaping(Result<UserMainDTO, MemoleaseError>) -> Void) {
        
        var urlComponents = URLComponents(string: path)
        
        print("\(path)🟩\(urlComponents?.url)")
        
        urlComponents?.queryItems = queryItems
        
        var urlRequest = URLRequest(url: (urlComponents?.url)!)
        urlRequest.httpBody = urlComponents?.query?.data(using: .utf8) //바디
        urlRequest.httpMethod = httpMethod.rawValue.uppercased()
        urlRequest.allHTTPHeaderFields = headers //헤더

        
        
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            
            guard let httpResponse = response as? HTTPURLResponse else { return }
            print("📭 Request \(urlRequest.url!)")
            print("🚩 Response \(httpResponse.statusCode)")
            
            guard let data = data else { print("데이터 없음"); return }
            do {
                let user = try JSONDecoder().decode(UserMainDTO.self, from: data)
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
            
            switch httpResponse.statusCode {
            case 401:
                completion(.failure(.firebaseTokenError))
            case 406:
                completion(.failure(.unRegistedUser))
            case 500:
                completion(.failure(.serverError))
            case 501:
                completion(.failure(.clientError))
            default:
                completion(.failure(.unknown))
            }
    
            
        }.resume()
        
    }
    
    func requestUserSubDTO(path: String, queryItems: [URLQueryItem]?, httpMethod: HTTPMethod, headers: [String: String], completion: @escaping(Result<UserSubDTO, MemoleaseError>) -> Void) {
        
        var urlComponents = URLComponents(string: path)
        
        print("\(path)🟩\(urlComponents?.url)")
        
        urlComponents?.queryItems = queryItems
        
        var urlRequest = URLRequest(url: (urlComponents?.url)!)
        urlRequest.httpBody = urlComponents?.query?.data(using: .utf8) //바디
        urlRequest.httpMethod = httpMethod.rawValue.uppercased()
        urlRequest.allHTTPHeaderFields = headers //헤더

        
        
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            
            guard let httpResponse = response as? HTTPURLResponse else { return }
            print("📭 Request \(urlRequest.url!)")
            print("🚩 Response \(httpResponse.statusCode)")
            
            guard let data = data else { print("데이터 없음"); return }
            do {
                let user = try JSONDecoder().decode(UserSubDTO.self, from: data)
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
            
            switch httpResponse.statusCode {
            case 401:
                completion(.failure(.firebaseTokenError))
            case 406:
                completion(.failure(.unRegistedUser))
            case 500:
                completion(.failure(.serverError))
            case 501:
                completion(.failure(.clientError))
            default:
                completion(.failure(.unknown))
            }
    
            
        }.resume()
        
    }
}

