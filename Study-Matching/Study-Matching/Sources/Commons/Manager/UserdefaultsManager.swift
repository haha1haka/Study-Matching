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
        case onboardFlag, sceneType, nickFlag, smsFlag, mainFlag
        case matchedState
        case myUid, matchedUid, matchedNick
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
            return userDefaults.string(forKey: UserDefaultsKey.idToken.rawValue) ?? ""
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
    
    
    var gender: Int {
        get {
            return userDefaults.integer(forKey: UserDefaultsKey.gender.rawValue)
        }
        set {
            userDefaults.set(newValue, forKey: UserDefaultsKey.gender.rawValue)
        }
    }
    

    var onboardFlag: Bool {
        get {
            return userDefaults.bool(forKey: UserDefaultsKey.onboardFlag.rawValue)
        }
        set {
            userDefaults.set(newValue, forKey: UserDefaultsKey.onboardFlag.rawValue)
        }
    }

    var sceneType: String {
        get {
            return userDefaults.string(forKey: UserDefaultsKey.sceneType.rawValue)!
        }
        set {
            userDefaults.set(newValue, forKey: UserDefaultsKey.sceneType.rawValue)
        }
    }
    
    var nickFlag: Bool {
        get {
            return userDefaults.bool(forKey: UserDefaultsKey.nickFlag.rawValue)
        }
        set {
            userDefaults.set(newValue, forKey: UserDefaultsKey.nickFlag.rawValue)
        }
    }
    
    var smsFlag: Bool {
        get {
            return userDefaults.bool(forKey: UserDefaultsKey.smsFlag.rawValue)
        }
        set {
            userDefaults.set(newValue, forKey: UserDefaultsKey.smsFlag.rawValue)
        }
    }
    
    var mainFlag: Bool {
        get {
            return userDefaults.bool(forKey: UserDefaultsKey.mainFlag.rawValue)
        }
        set {
            userDefaults.set(newValue, forKey: UserDefaultsKey.mainFlag.rawValue)
        }
    }
    
    var matchedState: Int {
        get {
            return userDefaults.integer(forKey: UserDefaultsKey.matchedState.rawValue)
        }
        set {
            userDefaults.set(newValue, forKey: UserDefaultsKey.matchedState.rawValue)
        }
    }


    var myUid: String {
        get {
            return userDefaults.string(forKey: UserDefaultsKey.myUid.rawValue) ?? ""
        }
        set {
            userDefaults.set(newValue, forKey: UserDefaultsKey.myUid.rawValue)
        }
    }
    
    var matchedUid: String {
        get {
            return userDefaults.string(forKey: UserDefaultsKey.matchedUid.rawValue) ?? "없음"
        }
        set {
            userDefaults.set(newValue, forKey: UserDefaultsKey.matchedUid.rawValue)
        }
    }
    var matchedNick: String {
        get {
            return userDefaults.string(forKey: UserDefaultsKey.matchedNick.rawValue) ?? "없음"
        }
        set {
            userDefaults.set(newValue, forKey: UserDefaultsKey.matchedNick.rawValue)
        }
    }
    
    
}


