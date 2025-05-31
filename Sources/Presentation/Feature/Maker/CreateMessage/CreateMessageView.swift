//
//  NewMessageView.swift
//  SecretTalker
//
//  Created by 황정현 on 6/1/25.
//

import SwiftUI

struct CreateMessageView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject var messageViewModel: MessageViewModel
    let onSubmit: (SecretMessage) -> Void
    
    var body: some View {
        GeometryReader { geo in
            HStack {
                VStack(spacing: 24) {
                    
                    MessageInputView(message: $messageViewModel.message)
                    PasswordInputView(password: $messageViewModel.password)

                    Spacer()
                    
                    InputFeedbackView(creationStatus: $messageViewModel.creationStatus)
                    Button(action: handleSubmit) {
                        Text("SUBMIT")
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.purple)
                            .cornerRadius(10)
                    }
                    .padding(.horizontal)
                }
                .padding(.top)
                .frame(width: geo.size.width * 0.95)
                Rectangle().fill(Color.red)
                    .frame(width: geo.size.width * 0.05)
            }
        }
    }
    
    func handleSubmit() {
        guard messageViewModel.isCreationAvailable() else { return }
        if let result = messageViewModel.encryptedMessage() {
            let new = SecretMessage(
                id: UUID(),
                encryptedText: result.encryptedText,
                salt: result.salt
            )
            onSubmit(new)
        }
        dismiss()
    }

}

