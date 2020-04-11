//
//  ButtonView.swift
//  SwiftUIDay6
//
//  Created by Jaesung Lee on 2020/04/06.
//  Copyright © 2020 Jaesung Lee. All rights reserved.
//

import SwiftUI

struct ButtonView: View {
    let text: String
    let width: CGFloat
    
    var body: some View {
        Text(text)
            .foregroundColor(Color(.systemBackground))
            .background(
                Color(#colorLiteral(red: 0.4823529412, green: 0.3254901961, blue: 0.937254902, alpha: 1))
                    .frame(width: self.width,
                       height: 56)
                .cornerRadius(4)
        )
        .padding(.vertical, 32)
    }
}


struct ButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonView(text: "Sign In", width: 200)
    }
}
