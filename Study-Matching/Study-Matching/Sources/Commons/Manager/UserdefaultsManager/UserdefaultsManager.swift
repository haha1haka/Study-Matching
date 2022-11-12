//
//  UserdefaultsManager.swift
//  Study-Matching
//
//  Created by HWAKSEONG KIM on 2022/11/12.
//

import Foundation

class UserDefaultsManager  {
    
    static let shared = UserDefaultsManager()
    
    private init() {}
    
    //⚠️ 개선 해보기 --> 시간 너무 많이 걸림
    func setVertificationID(_ str: String) {
        UserDefaults.standard.set(str, forKey: "vertificationID")
    }
    
    func getVertificationID() -> String? {
        return UserDefaults.standard.string(forKey: "vertificationID")
    }
    
    
}


