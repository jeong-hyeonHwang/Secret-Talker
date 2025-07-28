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
    let onSubmit: (CreatedSecretMessage) -> Void
    
    var body: some View {
        HStack {
            VStack(spacing: 24) {
                
                MessageInputView(message: $messageViewModel.message)
                PasswordInputView(password: $messageViewModel.password)
                    .environment(\.shapeButtonStyle, ShapeButtonStyle(ratio: 0.6))
                
                Spacer()
                
                InputFeedbackView(creationStatus: $messageViewModel.creationStatus)
                RoundedShapeButton(
                    action: { handleSubmit() },
                    title: "Mitte"
                )
                .padding(.horizontal)
            }
            .padding(.top)
        }
    }
    
    func handleSubmit() {
        if let newMessage = messageViewModel.createMessage() {
            onSubmit(newMessage)
            dismiss()
        }
    }
}

