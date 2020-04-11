//
//  LocalVideoView.swift
//  SwiftUIDay6
//
//  Created by Jaesung Lee on 2020/04/06.
//  Copyright © 2020 Jaesung Lee. All rights reserved.
//

import SwiftUI

struct LocalVideoView: View {
    var body: some View {
        VStack {
            HStack {
                Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.5))
                    .frame(width: 96, height: 160)
                    .cornerRadius(8)
                    .padding(.leading, 16)
                    .padding(.top, 16)
                
                Spacer()
            }
            
            Spacer()
        }
    }
}
