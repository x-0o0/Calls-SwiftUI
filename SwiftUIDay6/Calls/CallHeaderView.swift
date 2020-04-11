//
//  CallHeaderView.swift
//  SwiftUIDay6
//
//  Created by Jaesung Lee on 2020/04/06.
//  Copyright © 2020 Jaesung Lee. All rights reserved.
//

import SwiftUI

struct CallHeaderView: View {
    
    var body: some View {
        HStack {
            Image("iconAvatar")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 34, height: 34)
                .cornerRadius(17)
                .padding(.horizontal, 8)
            
            VStack(alignment: .leading) {
                Text(UserDefaults.standard.nickname ?? "Noname")
                    .font(.headline)
                    .bold()
                
                Text(UserDefaults.standard.userId)
                    .font(.subheadline)
            }
            
            Spacer()
        }
    }
}
