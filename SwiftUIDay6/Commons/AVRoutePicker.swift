//
//  AVRoutePicker.swift
//  SwiftUIDay6
//
//  Created by Jaesung Lee on 2020/04/10.
//  Copyright © 2020 Jaesung Lee. All rights reserved.
//

import AVKit
import SwiftUI
import SendBirdCalls

struct AudioRoutePicker: UIViewRepresentable {
    private let frame = CGRect(x: 0, y: 0, width: 64, height: 64)
    
    func makeUIView(context: Context) -> AVRoutePickerView {
        let routePickerview = SendBirdCall.routePickerView(frame: self.frame) as! AVRoutePickerView
        routePickerview.activeTintColor = .clear
        routePickerview.tintColor = .clear
        return routePickerview
    }
    
    func updateUIView(_ uiView: AVRoutePickerView, context: Context) {
        //
    }
}
