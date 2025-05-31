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
        HStack() {
            // 침묵 속에 너의 목소리를 보내라.
            Text("Vocem mitte per silentium")
                .font(.title2)
                .bold()
        }
        TextEditor(text: $message)
            .frame(height: 120)
            .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray.opacity(0.4)))
            .padding(.horizontal)
    }
}

struct PreviewMessageInputView: PreviewProvider {
    static var previews: some View {
        MessageInputView(message: .constant("Message"))
    }
}
