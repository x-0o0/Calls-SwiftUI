//
//  CustomView.swift
//  CallsUI
//
//  Created by 이재성 on 2020/01/18.
//  Copyright © 2020 Jaesung. All rights reserved.
//

import SwiftUI

struct CustomView: View {
    @Environment(\.presentationMode) var presentationMode
    var calleeId: String
    
    var body: some View {
        VStack(alignment: .center) {
            Spacer()
            VStack(alignment: .center) {
                Text(self.calleeId)
            }
            Spacer()
            HStack(alignment: .center) {
                Button(action: {
                    self.didEnd()
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Text("End")
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
    
    func didEnd() {
        
    }
}

struct CustomView_Previews: PreviewProvider {
    static var previews: some View {
        CustomView(calleeId: "Callee ID")
    }
}

