//
//  ProviderDelegate.swift
//  SwiftUIDay6
//
//  Created by Jaesung Lee on 2020/04/10.
//  Copyright © 2020 Jaesung Lee. All rights reserved.
//

import AVFoundation
import UIKit
import CallKit
import SendBirdCalls

typealias ErrorHandler = ((NSError?) -> ())

class ProviderDelegate: NSObject, CXProviderDelegate {
    
    let callManager: CallManager
    private let provider: CXProvider
    
    init(callManager: CallManager) {
        self.callManager = callManager
        provider = CXProvider.sendbird
        
        super.init()
        
        // if queue value is nil, delegate will run on main thread
        provider.setDelegate(self, queue: nil)
    }
    
    func reportIncomingCall(_ call: DirectCall, completionHandler: ErrorHandler? = nil) {
        guard let uuid = call.callUUID else {
            completionHandler?(NSError.noCallID)
            return
        }
        // Update call based on DirectCall object
        let update = CXCallUpdate()
        update.update(with: call, incoming: true)
        
        provider.reportNewIncomingCall(with: uuid, update: update) { error in
            guard error == nil else {
                completionHandler?(error as NSError?)
                return
            }
            
            // Add call to call manager
            self.callManager.addCall(call)
        }
    }
    
    func reportIncomingCall(with callUUID: UUID) {
        // Update call based on DirectCall object
        let update = CXCallUpdate()
        update.onFailed(with: callUUID)
        
        provider.reportNewIncomingCall(with: callUUID, update: update) { error in
            self.provider.reportCall(with: callUUID, endedAt: Date(), reason: .failed)
        }
    }
    
    func endCall(for callId: UUID, endedAt: Date, reason: CXCallEndedReason) {
        self.provider.reportCall(with: callId, endedAt: endedAt, reason: reason)
    }
    
    func connectedCall(_ call: DirectCall) {
        self.provider.reportOutgoingCall(with: call.callUUID!, connectedAt: Date(timeIntervalSince1970: Double(call.startedAt)/1000))
    }
    
    
    
    func providerDidReset(_ provider: CXProvider) {
        // Stop audio
        
        // End all calls because they are no longer valid
        self.callManager.calls.forEach { $0.end() }
        
        // Remove all calls from the app's list of call
        self.callManager.removeAllCalls()
    }
    
    func provider(_ provider: CXProvider, perform action: CXStartCallAction) {
        guard let call = SendBirdCall.getCall(forUUID: action.callUUID) else {
            action.fail()
            return
        }
        
        // configure audio session
        
        if call.myRole == .caller {
            self.callManager.addCall(call)
            provider.reportOutgoingCall(with: call.callUUID!, connectedAt: Date(timeIntervalSince1970: Double(call.startedAt)/1000))
        }
        
        action.fulfill()
    }
    
    func provider(_ provider: CXProvider, perform action: CXAnswerCallAction) {
        guard let call = SendBirdCall.getCall(forUUID: action.callUUID) else {
            action.fail()
            return
        }
        
        // configure audio session
        
        // Accept call
        let callOptions = CallOptions(isAudioEnabled: true, isVideoEnabled: call.isVideoCall, useFrontCamera: true)
        let acceptParams = AcceptParams(callOptions: callOptions)
        call.accept(with: acceptParams)
        
        // Notify incoming call accepted
        NotificationCenter.default.post(name: NSNotification.Name.DidCallAccepted, object: call)
        
        action.fulfill()
    }
    
    func provider(_ provider: CXProvider, perform action: CXEndCallAction) {
        guard let call = SendBirdCall.getCall(forUUID: action.callUUID) else {
            action.fail()
            return
        }
        
        call.muteMicrophone()
        call.end()
        
        action.fulfill()
        
        // Remove the ended call from the app's list of calls.
        callManager.removeCall(call)
    }
    
    func provider(_ provider: CXProvider, perform action: CXSetHeldCallAction) {
        guard let call = SendBirdCall.getCall(forUUID: action.callUUID) else {
            action.fail()
            return
        }
        
        // update holding state
        switch action.isOnHold {
        case true:
            call.muteMicrophone()
            if call.isVideoCall { call.stopVideo() }
        case false:
            call.unmuteMicrophone()
            if call.isVideoCall { call.startVideo() }
        }
        
        action.fulfill()
    }
    
    func provider(_ provider: CXProvider, perform action: CXSetMutedCallAction) {
        guard let call = SendBirdCall.getCall(forUUID: action.callUUID) else {
            action.fail()
            return
        }
        
        // stop / start audio
        action.isMuted ? call.muteMicrophone() : call.unmuteMicrophone()
        
        action.fulfill()
    }
    
    func provider(_ provider: CXProvider, didActivate audioSession: AVAudioSession) {
        // Start audio
    }
    
    func provider(_ provider: CXProvider, didDeactivate audioSession: AVAudioSession) {
        // Restart any non-call related audio now that the app's audio session has been
        // de-activated after having its priority restored to normal.
    }
}
