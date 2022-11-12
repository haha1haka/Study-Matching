//
//  UserdefaultsManager.swift
//  Study-Matching
//
//  Created by HWAKSEONG KIM on 2022/11/12.
//

import Foundation

class UserDefaultsManager  {
    
    static let standard = UserDefaultsManager()
    
    let userDefaults = UserDefaults.standard
        
    private init() {}
    
    enum UserDefaultsKey: String {
        case vertificationID
    }
    
    var vertificationID: String {
        get {
            return userDefaults.string(forKey: UserDefaultsKey.vertificationID.rawValue)!
        }
        set {
            userDefaults.set(newValue, forKey: UserDefaultsKey.vertificationID.rawValue)
        }
    }
    
    
    
}


