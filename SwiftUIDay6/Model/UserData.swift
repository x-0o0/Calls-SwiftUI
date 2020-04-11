//
//  UserData.swift
//  SwiftUIDay6
//
//  Created by Jaesung Lee on 2020/04/11.
//  Copyright © 2020 Jaesung Lee. All rights reserved.
//

import Foundation
import SendBirdCalls

extension UserDefaults {
    var autoLogin: Bool {
        get { return UserDefaults.standard.bool(forKey: "com.jaesung.sendbird.calls.sample.autologin") }
        set { UserDefaults.standard.set(newValue, forKey: "com.jaesung.sendbird.calls.sample.autologin") }
    }
    
    var userId: String {
        get { UserDefaults.standard.string(forKey: "com.jaesung.sendbird.calls.sample.user.id") ?? "" }
        set { UserDefaults.standard.set(newValue, forKey: "com.jaesung.sendbird.calls.sample.user.id") }
    }
    
    var nickname: String? {
        get { UserDefaults.standard.string(forKey: "com.jaesung.sendbird.calls.sample.user.nickname") }
        set { UserDefaults.standard.set(newValue, forKey: "com.jaesung.sendbird.calls.sample.user.nickname") }
    }
    
    var profile: String? {
        get { UserDefaults.standard.string(forKey: "com.jaesung.sendbird.calls.sample.user.profile") }
        set { UserDefaults.standard.set(newValue, forKey: "com.jaesung.sendbird.calls.sample.user.profile") }
    }
    
    var accessToken: String? {
        get { UserDefaults.standard.string(forKey: "com.jaesung.sendbird.calls.sample.token.access") }
        set { UserDefaults.standard.set(newValue, forKey: "com.jaesung.sendbird.calls.sample.token.access") }
    }
    
    var voipPushToken: Data? {
        get { UserDefaults.standard.data(forKey: "com.jaesung.sendbird.calls.sample.token.voip") }
        set { UserDefaults.standard.set(newValue, forKey: "com.jaesung.sendbird.calls.sample.token.voip") }
    }
    
    func store(user: User, accessToken: String? = nil, voipPushToken: Data? = nil) {
        self.userId = user.userId
        self.nickname = user.nickname
        self.profile = user.profileURL
        self.accessToken = accessToken
        self.voipPushToken = voipPushToken
    }
    
    func clear() {
        self.autoLogin = false
        self.userId = ""
        self.nickname = nil
        self.profile = nil
        self.accessToken = nil
    }
}
