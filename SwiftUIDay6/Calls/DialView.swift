//
//  CallView.swift
//  SwiftUIDay6
//
//  Created by Jaesung Lee on 2020/04/06.
//  Copyright © 2020 Jaesung Lee. All rights reserved.
//

import SwiftUI
import SendBirdCalls

struct DialView: View {
    @EnvironmentObject var callManager: CallManager
    @ObservedObject var callEvent = CallEvent()
    
    @State var showCallView = false
    @State var showAlert = false
    @State var call: DirectCall? = nil
    @State var userId: String = ""
    
    let message = "Enter the user ID of the user you wish to call, then press one of the video or voice call buttons"
    let endPublisher = NotificationCenter.default
        .publisher(for: Notification.Name.DidCallEnd)
    let acceptPublishser = NotificationCenter.default
        .publisher(for: Notification.Name.DidCallAccepted)
    
    var body: some View {
        GeometryReader() { geometry in
            VStack {
                CallHeaderView()
                    .padding(.leading, 16)
                
                Divider()
                
                GuideView(title: "Make a call", message: self.message)
                
                UserTextView(title: "User ID", text: self.$userId, width: geometry.size.width - 32)
                    .padding(.vertical, 40)
                    .disabled(self.showCallView)
                
                if self.showCallView {
                    
                    // MARK: Handle a call
                    VStack {
                        HStack {
                            
                            // Mute
                            
                            Button(action: self.muteAudio) {
                                Image(self.callEvent.localAudio ? "btnAudioOff" : "btnAudioOffSelected")
                                    .renderingMode(.original)
                            }
                            .padding(.horizontal, 12)
                            
                            
                            // Speaker
                            
                            Image(self.callEvent.audioDevice == .speaker ? "btnSpeakerSelected" : self.callEvent.audioDevice == .bluetooth ? "btnBluetoothSelected" : "btnSpeaker")
                                .renderingMode(.original)
                                .overlay(
                                    AudioRoutePicker()
                            )
                            .padding(.horizontal, 12)
                            
                            
                            // End
                            
                            Button(action: self.endCall) {
                                Image("btnCallEnd")
                                    .renderingMode(.original)
                            }
                            .padding(.horizontal, 12)
                        }
                    }
                    
                    Text(self.callEvent.callState.rawValue)
                        .padding(.vertical)
                    
                    Text(self.callEvent.remoteAudio ? "" : "\(self.userId) muted.")
                        .padding(.vertical)
                }
                else {
                    
                    // MARK: Make a call
                    
                    HStack {
                        
                        // Video
                        Button(action: {
                            self.showAlert = true
//                            self.startCall(to: self.$userId.wrappedValue, type: .video)
                        }) {
                            Image("btnCallVideo")
                                .renderingMode(.original)
                        }
                        .padding(.horizontal, 16)
                        .alert(isPresented: self.$showAlert) {
                            Alert(title: Text("This feature is not supported yet"), message: Text("Video call will be enabled soon."), dismissButton: .default(Text("OK, I See")))
                        }
                        
                        // Voice
                        Button(action: {
                            self.startCall(to: self.$userId.wrappedValue, type: .voice)
                        }) {
                            Image("btnCallVoice")
                                .renderingMode(.original)
                        }
                        .padding(.horizontal, 16)
                    }
                }
                
                Spacer()
            }
            .onReceive(self.endPublisher) { output in
                self.endCall()
            }
            .onReceive(self.acceptPublishser) { output in
                guard let call = output.object as? DirectCall else { return }
                self.acceptCall(call)
            }
        }
    }
    
    // MARK: Actions for Call
    func startCall(to userId: String, type: CallType) {
        let callOptions = CallOptions(isAudioEnabled: true,
                                      isVideoEnabled: type == .video,
                                      localVideoView: nil,
                                      remoteVideoView: nil,
                                      useFrontCamera: true)
        let dialParams = DialParams(calleeId: userId,
                                    isVideoCall: type == .video,
                                    callOptions: callOptions,
                                    customItems: [:])
        
        print("[\(type.rawValue)] Will start call to \(userId)")
        SendBirdCall.dial(with: dialParams) { call, error in
            guard let call = call, error == nil else { return }
            print("Outgoing Call - ID: \(call.callId)")
            self.call = call
            self.callManager.startCall(call)
            
            DispatchQueue.main.async {
                self.callEvent.update(state: .onCalling, of: call)
                withAnimation { self.showCallView = true }
            }
        }
    }
    
    func acceptCall(_ call: DirectCall) {
        self.userId = call.remoteUser?.userId ?? "Unknown Caller"
        self.call = call
        self.callEvent.update(state: .onEstablished, of: call)
        withAnimation { self.showCallView = true }
    }
    
    func endCall() {
        guard let call = self.call else { return }
        self.callManager.endCall(call)
        withAnimation { self.showCallView = false }
    }
    
    func muteAudio() {
        guard let call = self.call else { return }
        callEvent.localAudio = !call.isLocalAudioEnabled
        
        switch call.isLocalAudioEnabled {
            case true: call.muteMicrophone()
            case false: call.unmuteMicrophone()
        }
    }
    
    
}

struct Dial_Previews: PreviewProvider {
    static var previews: some View {
        DialView()
    }
}
