//
//  CallManager.swift
//  SwiftUIDay6
//
//  Created by Jaesung Lee on 2020/04/10.
//  Copyright © 2020 Jaesung Lee. All rights reserved.
//

import CallKit
import Combine
import SendBirdCalls

class CallManager: NSObject, ObservableObject {
    static let shared = CallManager()
    
    let callController = CXCallController()
    private(set) var calls: [DirectCall] = []
    
    // MARK: Actions
    
    func startCall(_ call: DirectCall, completionHandler: ErrorHandler? = nil) {
        guard let uuid = call.callUUID else {
            completionHandler?(NSError.noCallID)
            return
        }
        
        let userId = call.callee?.userId ?? "Unknown"
        let handle = CXHandle(type: .generic, value: userId)
        
        let startCallAction = CXStartCallAction(call: uuid, handle: handle)
        startCallAction.isVideo = call.isVideoCall
        
        let transaction = CXTransaction(action: startCallAction)
        self.requestTransaction(transaction, completionHandler: completionHandler)
    }
    
    func endCall(_ call: DirectCall, completionHandler: ErrorHandler? = nil) {
        guard let uuid = call.callUUID else {
            completionHandler?(NSError.noCallID)
            return
        }
        
        let endCallAction = CXEndCallAction(call: uuid)
        
        let transaction = CXTransaction(action: endCallAction)
        self.requestTransaction(transaction, completionHandler: completionHandler)
    }
    
    func setHeldCall(_ call: DirectCall, onHold: Bool, completionHandler: ErrorHandler?) {
        guard let uuid = call.callUUID else {
            completionHandler?(NSError.noCallID)
            return
        }
        
        let setHeldCallAction = CXSetHeldCallAction(call: uuid, onHold: onHold)
        let transaction = CXTransaction(action: setHeldCallAction)
        self.requestTransaction(transaction, completionHandler: completionHandler)
    }
    
    private func requestTransaction(_ transaction: CXTransaction, completionHandler: ErrorHandler?) {
        callController.request(transaction) { error in
            guard error == nil else {
                print("Error requesting transaction: \(error?.localizedDescription ?? "")")
                completionHandler?(error as NSError?)
                return
            }
            print("Requested transaction successfully")
            completionHandler?(nil)
        }
    }
    
    
    // MARK: Call Management
    func addCall(_ call: DirectCall) {
        calls.append(call)
    }
    
    func removeCall(_ call: DirectCall) {
        calls.removeAll(where: { $0 === call })
    }
    
    func removeAllCalls() {
        calls.removeAll()
    }
}
