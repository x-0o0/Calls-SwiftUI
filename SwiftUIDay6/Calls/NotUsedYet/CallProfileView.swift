//
//  CallProfileView.swift
//  SwiftUIDay6
//
//  Created by Jaesung Lee on 2020/04/06.
//  Copyright © 2020 Jaesung Lee. All rights reserved.
//

import SwiftUI
import SendBirdCalls

struct CallProfileView: View {
    let user: User?
    
    var body: some View {
        VStack {
            Image(user?.profileURL ?? "iconAvatar")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 80, height: 80)
                .cornerRadius(40)
                .padding(.top, 140)
            
            Text(user?.nickname ?? "No Name User")
                .font(.headline)
                .foregroundColor(.white)
                .padding(.vertical, 16)
        }
    }
}
