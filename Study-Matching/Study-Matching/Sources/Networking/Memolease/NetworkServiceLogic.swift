//
//  NetworkServiceLogic.swift
//  Study-Matching
//
//  Created by HWAKSEONG KIM on 2022/11/28.
//

import Foundation

class NetworkServiceLogic {
    
    static let shared = NetworkServiceLogic()
    
    var session: URLSession {
        return URLSession.shared
    }
    
    private init() {}
    
    
}
