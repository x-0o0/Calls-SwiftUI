//
//  VoiceCallView.swift
//  SwiftUIDay6
//
//  Created by Jaesung Lee on 2020/04/06.
//  Copyright © 2020 Jaesung Lee. All rights reserved.
//

import SwiftUI
import AVKit
import SendBirdCalls

struct CallView: View {
    @Environment(\.presentationMode) var presentationMode

    @ObservedObject var callManager = CallManager()
    @State private var changeAudioRoute = false
    
    let call: DirectCall?
    
    var body: some View {
        ZStack {
            Color(#colorLiteral(red: 0.2274459004, green: 0.2274520993, blue: 0.2274487615, alpha: 1))
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                CallProfileView(user: self.call?.remoteUser)
                
                Spacer()
                
                HStack {
                    // MARK: Mute
                    Button(action: {
                        guard let call = self.call else { return }
                        if call.isLocalAudioEnabled { call.muteMicrophone() }
                        else { call.unmuteMicrophone() }
                    }) {
                        Image("btnAudioOff")
                            .renderingMode(.original)
                    }
                    .padding(.horizontal, 12)
                    
                    // MARK: Change CallType
                    Button(action: {
                        // change call type
                    }) {
                        Image("btnCallChange")
                            .renderingMode(.original)
                    }
                    .padding(.horizontal, 12)
                    
                    // MARK: Speaker
                    
                    Button(action: {
                        self.changeAudioRoute = true
                    }) {
                        Image("btnSpeaker")
                            .renderingMode(.original)
                    }
                    .padding(.horizontal, 12)
                }
                .padding(.bottom, 24)
                
                // MARK: End
                Button(action: {
                    if let call = self.call { self.callManager.endCall(call) }
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Image("btnCallEnd")
                        .renderingMode(.original)
                }
                .padding(.horizontal, 12)
            }
            
            LocalVideoView()
        }
    }
}

struct CallView_Previews: PreviewProvider {
    static var previews: some View {
        CallView(call: nil)
    }
}
