//
//  UserDefault.swift
//  SwiftUIDay6
//
//  Created by Jaesung Lee on 2020/04/11.
//  Copyright © 2020 Jaesung Lee. All rights reserved.
//

import Foundation

@propertyWrapper
struct UserDefault<T> {
    let key: String
    let defaultValue: T
    
    init(_ key: String, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
        
        UserDefaults.standard.register(defaults: [key: defaultValue])
    }
    
    var wrappedValue: T {
        get {
            return UserDefaults.standard.object(forKey: key) as? T ?? defaultValue
        }
        set {
            UserDefaults.standard.set(newValue, forKey: key)
        }
    }
}

class UserData {
    @UserDefault("AUTO_SIGN_IN", defaultValue: false)
    static var autoLogin: Bool
    
    @UserDefault("USER_ID", defaultValue: "")
    static var userId: String
    
    @UserDefault("USER_NICKNAME", defaultValue: nil)
    static var nickname: String?
    
    @UserDefault("USER_PROFILE", defaultValue: nil)
    static var profile: String?
    
    @UserDefault("ACCESS_TOKEN", defaultValue: nil)
    static var accessToken: String?
    
    @UserDefault("VOIP_PUSH_TOKEN", defaultValue: nil)
    static var voipPushToken: String?
}
