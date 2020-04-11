//
//  GuideView.swift
//  SwiftUIDay6
//
//  Created by Jaesung Lee on 2020/04/06.
//  Copyright © 2020 Jaesung Lee. All rights reserved.
//

import SwiftUI

struct GuideView: View {
    let title: String
    let message: String
    
    var body: some View {
        VStack {
            Text(title)
                .font(.title)
                .bold()
                .padding(.top, 100)
            
            Text(message)
                .font(.subheadline)
                .foregroundColor(Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.5)))
                .multilineTextAlignment(.center)
                .padding(.top, 16)
                .padding(.horizontal, 24)
        }
    }
}
