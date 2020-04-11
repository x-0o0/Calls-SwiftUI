//
//  SceneDelegate.swift
//  SwiftUIDay6
//
//  Created by Jaesung Lee on 2020/04/06.
//  Copyright © 2020 Jaesung Lee. All rights reserved.
//

import UIKit
import SwiftUI
import SendBirdCalls

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).

        // Create the SwiftUI view that provides the window contents.
        let contentView = ContentView()

        // Use a UIHostingController as window root view controller.
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = UIHostingController(rootView: contentView.environmentObject(CallManager.shared))
            self.window = window
            window.makeKeyAndVisible()
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) { }

    func sceneDidBecomeActive(_ scene: UIScene) { }

    func sceneWillResignActive(_ scene: UIScene) { }

    func sceneWillEnterForeground(_ scene: UIScene) { }

    func sceneDidEnterBackground(_ scene: UIScene) { }
}
//
//extension SceneDelegate: SendBirdCallDelegate {
//    func didStartRinging(_ call: DirectCall) {
//        guard let providerDelegate = self.providerDelegate else { return }
//        guard !providerDelegate.callManager.calls.contains(where: { $0 === call }) else { return }
//
//        // Display the incoming call to the user
//        providerDelegate.reportIncomingCall(call)
//    }
//}
//
//extension SceneDelegate: DirectCallDelegate {
//    func didConnect(_ call: DirectCall) {
//
//    }
//
//    func didEnd(_ call: DirectCall) {
//        
//    }
//
//
//}
//
