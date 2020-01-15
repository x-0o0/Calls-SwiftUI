//
//  DialingView.swift
//  CallsUI
//
//  Created by 이재성 on 2020/01/15.
//  Copyright © 2020 Jaesung. All rights reserved.
//

import SwiftUI

struct DialingView: View {
    @State private var isNeedSignIn = true
    @State var calleeId: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    TextField("Whom do you call", text: $calleeId)
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
        }.sheet(isPresented: self.$isNeedSignIn) {
            SignInView()
        }
    }
    
    func showAccount() {
        
    }
}

struct DialingView_Previews: PreviewProvider {
    static var previews: some View {
        DialingView()
    }
}
