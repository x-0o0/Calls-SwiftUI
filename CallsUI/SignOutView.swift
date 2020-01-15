//
//  SignOutView.swift
//  CallsUI
//
//  Created by 이재성 on 2020/01/15.
//  Copyright © 2020 Jaesung. All rights reserved.
//

import UIKit
import SwiftUI

struct SignOutView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Spacer()
            Text("USER ID")
                .font(.title)
                .multilineTextAlignment(.leading)
                .padding(.leading, 20)
            Text("YOUR-APP-ID-HERE")
                .font(.subheadline)
                .padding(.leading, 20)
            Spacer()
            HStack {
                Button(action: {
                }) {
                    Text("Sign Out")
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                }
                .padding(.horizontal, 120)
                .frame(height: 40.0)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.black, lineWidth: 2)
                )
            }.padding()
        }.padding()
    }
}

struct SignOutView_Previews: PreviewProvider {
    static var previews: some View {
        SignOutView()
    }
}
