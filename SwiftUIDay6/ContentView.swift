//
//  ContentView.swift
//  SwiftUIDay6
//
//  Created by Jaesung Lee on 2020/04/06.
//  Copyright © 2020 Jaesung Lee. All rights reserved.
//

import SwiftUI
import SendBirdCalls

struct ContentView: View {
    @EnvironmentObject var callManager: CallManager
    @State var showSignInView = !UserDefaults.standard.autoLogin
    
    var body: some View {
        VStack {
            DialView()
            
            Button(action: self.signOut) {
                ButtonView(text: "Sign Out", width: 160)
            }
        }
        .sheet(isPresented: self.$showSignInView) {
            SignInView()
        }
    }
    
    func signOut() {
        SendBirdCall.deauthenticate(voipPushToken: UserDefaults.standard.voipPushToken) { error in
            UserDefaults.standard.clear()
            
            DispatchQueue.main.async {
                self.showSignInView = !UserDefaults.standard.autoLogin
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
