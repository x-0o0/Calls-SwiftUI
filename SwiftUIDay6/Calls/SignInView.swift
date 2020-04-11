//
//  SignInView.swift
//  SwiftUIDay6
//
//  Created by Jaesung Lee on 2020/04/06.
//  Copyright © 2020 Jaesung Lee. All rights reserved.
//

import SwiftUI
import SendBirdCalls

struct SignInView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State private var isSignIn = false
    @State private var userId: String = ""
    @State private var nickname: String = ""
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Image("logoSendbird")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 48, height: 48)
                    .padding(.top, 96)
                
                Text("SendBird Calls")
                    .font(.title)
                    .bold()
                    .padding(.vertical, 8)
                
                UserTextView(title: "User ID", text: self.$userId, width: geometry.size.width - 32)
                
                Button(action: self.signIn) {
                    ButtonView(text: "Sign In", width: geometry.size.width - 32)
                }
                
                Spacer()
                
                Text("SendBirdCall iOS ver\(SendBirdCall.sdkVersion)")
                    .font(.footnote)
                    .foregroundColor(.gray)
            }
        }
    }
    
    func signIn() {
        let authParams = AuthenticateParams(userId: self.userId, accessToken: nil, voipPushToken: nil, unique: true)
        SendBirdCall.authenticate(with: authParams) { user, error in
            guard let user = user, error == nil else { return }
            UserDefaults.standard.autoLogin = true
            UserDefaults.standard.store(user: user, accessToken: authParams.accessToken, voipPushToken: authParams.voipPushToken)
            print("Signed in successfully")
            self.presentationMode.wrappedValue.dismiss()
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}


