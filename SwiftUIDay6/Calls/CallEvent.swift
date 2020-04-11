//
//  CallEvent.swift
//  SwiftUIDay6
//
//  Created by Jaesung Lee on 2020/04/10.
//  Copyright © 2020 Jaesung Lee. All rights reserved.
//

import Combine
import Foundation
import AVFoundation
import SendBirdCalls

extension Notification.Name {
    static let DidCallEnd = Notification.Name("DidCallEnd")
    
    static let DidCallAccepted = Notification.Name("DidCallAccepted")
}

class CallEvent: ObservableObject, DirectCallDelegate {
    enum CallState: String {
        case onInitialized = "Initialized"
        case onCalling = "Calling..."
        case onRinging = "Ringing..."
        case onEstablished = "Connecting..."
        case onConnected = "Connected"
        case onReconnecting = "Reconnecting..."
        case onEnded = "Ended"
    }
    
    enum AudioDevice: String {
        case builtInReceiver = "Built-In Receiver"
        case speaker = "Speaker"
        case bluetooth = "Bluetooth"
        case headphone = "Headphone"
        case unspecified = "Unspecified"
    }
    
    @Published var callState: CallState = .onInitialized
    @Published var audioDevice: AudioDevice = .unspecified
    @Published var localAudio: Bool = true
    @Published var localVideo: Bool = true
    @Published var remoteAudio: Bool = true
    @Published var remoteVideo: Bool = true
    
    func update(state: CallState, of call: DirectCall) {
        self.callState = state
        call.delegate = self
    }
    
    // MARK: Events about Connection
    func didEstablish(_ call: DirectCall) {
        self.callState = .onEstablished
    }
    
    func didConnect(_ call: DirectCall) {
        self.callState = .onConnected
    }
    
    func didStartReconnecting(_ call: DirectCall) {
        self.callState = .onReconnecting
    }
    
    func didReconnect(_ call: DirectCall) {
        self.callState = .onConnected
    }
    
    func didEnd(_ call: DirectCall) {
        self.callState = .onEnded
        
        // Notify call was ended
        NotificationCenter.default.post(name: NSNotification.Name.DidCallEnd, object: nil)
    }
    
    // MARK: Events about Media State
    func didRemoteAudioSettingsChange(_ call: DirectCall) {
        self.remoteAudio = call.isRemoteAudioEnabled
    }
    
    func didRemoteVideoSettingsChange(_ call: DirectCall) {
        self.remoteVideo = call.isRemoteVideoEnabled
    }
    
    func didAudioDeviceChange(_ call: DirectCall, session: AVAudioSession, previousRoute: AVAudioSessionRouteDescription, reason: AVAudioSession.RouteChangeReason) {
        guard let output = session.currentRoute.outputs.first else { return }
        switch output.portType {
            case .builtInReceiver:
                self.audioDevice = .builtInReceiver
            case .builtInSpeaker:
                self.audioDevice = .speaker
            case .bluetoothLE, .bluetoothHFP, .bluetoothA2DP:
                self.audioDevice = .bluetooth
            case .headphones, .lineOut:
                self.audioDevice = .headphone
            default:
                self.audioDevice = .unspecified
        }
    }
}
