import Foundation




class MemoleaseService {
    
    static let shared = MemoleaseService()
    
    private init() {}
    
    func requestSignup(path: String, queryItems: [URLQueryItem], httpMethod: HTTPMethod, headers: [String: String], completion: @escaping(Result<Succeess, MemoleaseError>) -> Void) {
        
        var urlComponents = URLComponents(string: MemoleaseRouter.baseURL)
        urlComponents?.path = path
        urlComponents?.queryItems = queryItems

        var urlRequest = URLRequest(url: (urlComponents?.url)!)
        urlRequest.httpBody = urlComponents?.query?.data(using: .utf8) //바디
        urlRequest.httpMethod = httpMethod.rawValue.uppercased()
        urlRequest.allHTTPHeaderFields = headers //헤더
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            
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
            
            
        }.resume()
        
    }
    
}

