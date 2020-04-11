//
//  AppDelegate.swift
//  SwiftUIDay6
//
//  Created by Jaesung Lee on 2020/04/06.
//  Copyright © 2020 Jaesung Lee. All rights reserved.
//

import UIKit
import CallKit
import PushKit
import SendBirdCalls

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    let pushRegistry = PKPushRegistry(queue: DispatchQueue.main)
    let callManager = CallManager()
    var providerDelegate: ProviderDelegate?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        SendBirdCall.configure(appId: "APP_ID")
        SendBirdCall.addDelegate(self, identifier: "com.sendbird.calls.quickstart.delegate")
        
        if UserDefaults.standard.autoLogin {
            let authParams = AuthenticateParams(userId: UserDefaults.standard.userId,
                                                accessToken: nil,
                                                voipPushToken: nil,
                                                unique: true)
            SendBirdCall.authenticate(with: authParams) { user, error in
                guard let user = user, error == nil else { return }
                UserDefaults.standard.store(user: user)
                print("Signed in successfully")
            }
        }
        
        pushRegistry.delegate = self
        pushRegistry.desiredPushTypes = [.voIP]

        providerDelegate = ProviderDelegate(callManager: callManager)
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
}

extension AppDelegate: PKPushRegistryDelegate {
    // MARK: PKPushRegistryDelegate
    func pushRegistry(_ registry: PKPushRegistry, didUpdate credentials: PKPushCredentials, for type: PKPushType) {
        // Store push credentials on server for the active user.
        // For sample app purposes, do nothing since everything is being done locally.
        print(credentials.token.toHexString())
        UserDefaults.standard.voipPushToken = credentials.token
        
        SendBirdCall.registerVoIPPush(token: credentials.token, unique: true) { error in
            guard error == nil else { return }
            // Even if an error occurs, SendBirdCalls will save the pushToken value and reinvoke this method internally while authenticating.
        }
    }

    func pushRegistry(_ registry: PKPushRegistry, didReceiveIncomingPushWith payload: PKPushPayload, for type: PKPushType) {
        SendBirdCall.pushRegistry(registry, didReceiveIncomingPushWith: payload, for: type, completionHandler: nil)
    }
    
    func pushRegistry(_ registry: PKPushRegistry, didReceiveIncomingPushWith payload: PKPushPayload, for type: PKPushType, completion: @escaping () -> Void) {
        SendBirdCall.pushRegistry(registry, didReceiveIncomingPushWith: payload, for: type) { uuid in
            guard uuid != nil else {
                let update = CXCallUpdate()
                update.remoteHandle = CXHandle(type: .generic, value: "invalid")
                let randomUUID = UUID()
                
                self.providerDelegate?.reportIncomingCall(with: randomUUID)
                completion()
                return
            }
            completion()
        }
    }
}

extension AppDelegate: SendBirdCallDelegate {
    func didStartRinging(_ call: DirectCall) {
        call.delegate = self
        
        guard let providerDelegate = self.providerDelegate else { return }
        guard !providerDelegate.callManager.calls.contains(where: { $0 === call }) else { return }
        
        // Display the incoming call to the user
        providerDelegate.reportIncomingCall(call)
    }
}

extension AppDelegate: DirectCallDelegate {
    func didConnect(_ call: DirectCall) {
        //
    }
    
    func didEnd(_ call: DirectCall) {
        CallManager.shared.endCall(call)
    }
    
    
}

extension Data {
    func toHexString() -> String {
        return self.map { String(format: "%02x", $0) }.joined()
    }
}
