//
//  UserTextView.swift
//  SwiftUIDay6
//
//  Created by Jaesung Lee on 2020/04/06.
//  Copyright © 2020 Jaesung Lee. All rights reserved.
//

import SwiftUI

struct UserTextView: View {
    let title: String
    @Binding var text: String
    let width: CGFloat
    
    var body: some View {
        TextField(title, text: self.$text)
            .background(
                Color(.secondarySystemBackground)
                    .frame(width: self.width,
                           height: 56)
                    .cornerRadius(4)
        )
        .padding(.horizontal, 32)
        .padding(.vertical, 16)
    }
    
    init(title: String, text: Binding<String>, width: CGFloat) {
        self.title = title
        self._text = text
        self.width = width
    }
}
