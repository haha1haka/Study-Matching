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
        case vertificationID, FCMToken, idToken
        case phoneNumber, nick, birth, email, gender
    }
    
    var vertificationID: String {
        get {
            return userDefaults.string(forKey: UserDefaultsKey.vertificationID.rawValue)!
        }
        set {
            userDefaults.set(newValue, forKey: UserDefaultsKey.vertificationID.rawValue)
        }
    }
    
    var FCMToken: String {
        get {
            return userDefaults.string(forKey: UserDefaultsKey.FCMToken.rawValue)!
        }
        set {
            userDefaults.set(newValue, forKey: UserDefaultsKey.FCMToken.rawValue)
        }
    }
    
    var idToken: String {
        get {
            return userDefaults.string(forKey: UserDefaultsKey.idToken.rawValue)!
        }
        set {
            userDefaults.set(newValue, forKey: UserDefaultsKey.idToken.rawValue)
        }
    }
    
    
    var phoneNumber: String {
        get {
            return userDefaults.string(forKey: UserDefaultsKey.phoneNumber.rawValue)!
        }
        set {
            userDefaults.set(newValue, forKey: UserDefaultsKey.phoneNumber.rawValue)
        }
    }
    
    var nick: String {
        get {
            return userDefaults.string(forKey: UserDefaultsKey.nick.rawValue)!
        }
        set {
            userDefaults.set(newValue, forKey: UserDefaultsKey.nick.rawValue)
        }
    }
    
    var birth: String {
        get {
            return userDefaults.string(forKey: UserDefaultsKey.birth.rawValue)!
        }
        set {
            userDefaults.set(newValue, forKey: UserDefaultsKey.birth.rawValue)
        }
    }
    
    
    var email: String {
        get {
            return userDefaults.string(forKey: UserDefaultsKey.email.rawValue)!
        }
        set {
            userDefaults.set(newValue, forKey: UserDefaultsKey.email.rawValue)
        }
    }
    
    
    var gender: Bool {
        get {
            return userDefaults.bool(forKey: UserDefaultsKey.gender.rawValue)
        }
        set {
            userDefaults.set(newValue, forKey: UserDefaultsKey.gender.rawValue)
        }
    }
    


    
    
    
}


