//
//  CallButtonView.swift
//  SwiftUIDay6
//
//  Created by Jaesung Lee on 2020/04/06.
//  Copyright © 2020 Jaesung Lee. All rights reserved.
//

import SwiftUI
import SendBirdCalls

struct CallButtonView: View {
    @ObservedObject var callManager = CallManager()
    
    @Binding var showCallView: Bool
    @Binding var call: DirectCall?
    @Binding var userId: String
    
    let callType: CallType
    
    var body: some View {
        Button(action: {
            self.startCall(to: self.$userId.wrappedValue)
        }) {
            Image("btnCall\(callType.rawValue)")
                .renderingMode(.original)
        }
    }
    
    func startCall(to userId: String) {
        let callOptions = CallOptions(isAudioEnabled: true,
                                      isVideoEnabled: callType == .video,
                                      localVideoView: nil,
                                      remoteVideoView: nil,
                                      useFrontCamera: true)
        let dialParams = DialParams(calleeId: userId,
                                    isVideoCall: callType == .video,
                                    callOptions: callOptions,
                                    customItems: [:])
        
        print("[\(callType.rawValue)] Will start call to \(userId)")
        SendBirdCall.dial(with: dialParams) { call, error in
            guard let call = call, error == nil else { return }
            print("Outgoing Call - ID: \(call.callId)")
            self.call = call
            self.callManager.startCall(call)
            
            self.showCallView = true
        }
    }
}

struct CallButtonView_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
