//
//  MessageInputView.swift
//  SecretTalker
//
//  Created by 황정현 on 7/3/25.
//

import SwiftUI

struct MessageInputView: View {
    @Binding var message: String
    
    var body: some View {
        HStack {
            Text(String(localized: "creator_title"))
                .font(.orbitronTitle2)
                .bold()
        }
        TextEditor(text: $message)
            .frame(height: 120)
            .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray.opacity(0.4)))
            .padding(.horizontal)
    }
}
