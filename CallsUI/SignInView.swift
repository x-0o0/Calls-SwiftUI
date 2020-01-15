//
//  SignInView.swift
//  CallsUI
//
//  Created by 이재성 on 2020/01/15.
//  Copyright © 2020 Jaesung. All rights reserved.
//

import SwiftUI

struct SignInView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var userId: String = ""
    
    var body: some View {
        VStack(alignment: .center) {
            Spacer(minLength: 148)
            Text("CallKit App")
                .font(.largeTitle)
                .fontWeight(.medium)
                .foregroundColor(.init(red: 109 / 255, green: 118 / 255, blue: 181 / 255))
                .padding()
            Text("SwiftUI")
                .font(.title)
                .fontWeight(.medium)
                .foregroundColor(.init(red: 109 / 255, green: 118 / 255, blue: 181 / 255))
                .padding()
            VStack(alignment: .leading) {
                Spacer()
                Text("USER ID")
                    .font(.subheadline)
                    .multilineTextAlignment(.leading)
                    .padding(.leading, 20)
                TextField("User ID", text: $userId)
                    .padding(.horizontal, 20)
                    .frame(height: 35.0)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.black, lineWidth: 1))
                Spacer()
            }
            .padding()
            
            VStack(alignment: .center) {
                HStack(alignment: .center) {
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("Sign In")
                            .fontWeight(.medium)
                            .foregroundColor(.black)
                    }
                    .padding(.horizontal, 120)
                    .frame(height: 40.0)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.black, lineWidth: 2)
                    )
                }
                .padding()
            }
        }
    }
    
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
