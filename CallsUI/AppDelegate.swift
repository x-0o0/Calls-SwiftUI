//
//  AppDelegate.swift
//  CallsUI
//
//  Created by 이재성 on 2020/01/15.
//  Copyright © 2020 Jaesung. All rights reserved.
//

import UIKit
import CallKit
import PushKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var voipPushRegisty: PKPushRegistry?
    var provider: CXProvider?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
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


extension AppDelegate: CXProviderDelegate {
    func providerDidReset(_ provider: CXProvider) {
        //
    }
    
    
}

extension AppDelegate: PKPushRegistryDelegate {
    func pushRegistry(_ registry: PKPushRegistry, didUpdate pushCredentials: PKPushCredentials, for type: PKPushType) {
        let pushToken = pushCredentials.token
    }
    
    func pushRegistry(_ registry: PKPushRegistry, didReceiveIncomingPushWith payload: PKPushPayload, for type: PKPushType, completion: @escaping () -> Void) {
        // received incoming call
        // report
        let callUUID = UUID()
        let configuration = CXProviderConfiguration(localizedName: "Name")
        configuration.maximumCallsPerCallGroup = 1
        self.provider = CXProvider(configuration: configuration)
        self.provider?.setDelegate(self, queue: nil)
        self.provider?.reportNewIncomingCall(with: callUUID, update: CXCallUpdate(), completion: { error in
            guard let error = error else { return }
            print(error.localizedDescription)
        })
    }
}
