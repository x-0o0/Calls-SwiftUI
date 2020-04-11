//
//  CXCallUpdate.swift
//  SwiftUIDay6
//
//  Created by Jaesung Lee on 2020/04/10.
//  Copyright © 2020 Jaesung Lee. All rights reserved.
//

import CallKit
import SendBirdCalls

extension CXCallUpdate {
    func update(with call: DirectCall, incoming: Bool) {
        let userId = incoming ? (call.caller?.userId ?? "Unknown") : (call.callee?.userId ?? "Unknown")
        // the other caller is identified by a CXHandle object
        let remoteHandle = CXHandle(type: .generic, value: userId)
        
        self.remoteHandle = remoteHandle
        self.localizedCallerName = userId
        self.hasVideo = call.isVideoCall
    }
    
    func onFailed(with uuid: UUID) {
        let remoteHandle = CXHandle(type: .generic, value: "Unknown")
        
        self.remoteHandle = remoteHandle
        self.localizedCallerName = "Unknown"
        self.hasVideo = false
    }
}
