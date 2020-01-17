//
//  DialingView.swift
//  CallsUI
//
//  Created by 이재성 on 2020/01/15.
//  Copyright © 2020 Jaesung. All rights reserved.
//

import SwiftUI

struct DialingView: View {
    @State var isPresent = true
    @State var calleeId: String = ""
    @State var isSignedIn = false
    
    private var isNeedSignIn = true
    private var onCall = false
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    TextField("Whom do you call", text: self.$calleeId)
                        .padding(.horizontal, 20)
                        .frame(height: 35.0)
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(Color.black, lineWidth: 1))
                }.padding(.horizontal, 40)
                
                HStack {
                    Button(action: {
                    }) {
                        Text("Call")
                            .fontWeight(.medium)
                            .foregroundColor(.black)
                    }
                    .padding(.horizontal, 120.0)
                    .frame(height: 40.0)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.black, lineWidth: 2)
                    )
                    .contextMenu {
                        Button("🤫 Mute My Audio") {
            
                        }
                        Button("😎 Mute My Video") {
                            
                        }
                        Button("📹 Video Call") {
                                
                        }
                    }
                }.padding()
            }
            .navigationBarTitle("Calls")
            .navigationBarItems(trailing: Button(action: {
                self.showAccount()
            }) {
                Image(systemName: "person.circle.fill")
                })
        }
        .sheet(isPresented: self.$isPresent) {
            if self.isSignedIn {
                SignOutView()
            } else {
                SignInView()
            }
        }
    }
    
    func showAccount() {
        self.isSignedIn = true
        self.isPresent = true
    }
}

struct DialingView_Previews: PreviewProvider {
    static var previews: some View {
        DialingView()
    }
}
