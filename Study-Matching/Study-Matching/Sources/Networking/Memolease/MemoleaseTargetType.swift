//
//  MemoleaseTargetType.swift
//  Study-Matching
//
//  Created by HWAKSEONG KIM on 2022/11/22.
//

import Foundation

protocol TargetType {
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var queryItems: [URLQueryItem]? { get }
    var headers: [String: String] { get }
}

extension TargetType {
    
    var components: URLComponents {
      var components = URLComponents()
      components.path = path
      components.queryItems = queryItems
      return components
    }
    
    var request: URLRequest {
        let url = URL(string: components.path)
        var request = URLRequest(url: url!)
        request.httpBody = components.query?.data(using: .utf8)
        request.httpMethod = httpMethod.rawValue.uppercased()
        request.allHTTPHeaderFields = headers
        return request
    }
}

