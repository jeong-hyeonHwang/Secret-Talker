//
//  MessageResolverViewModel.swift
//  SecretTalker
//
//  Created by 황정현 on 7/24/25.
//

import SwiftUI
import Combine

@MainActor
public final class MessageResolverViewModel: ObservableObject {
    @Published var password: String = ""
    @Published var feedbackText: String?

    private let message: ScannedSecretMessage
    private let onSuccess: (String) -> Void

    init(message: ScannedSecretMessage, onSuccess: @escaping (String) -> Void) {
        self.message = message
        self.onSuccess = onSuccess
    }

    func appendPassword(_ digit: String) {
        password += digit
    }

    func clear() {
        password = ""
        feedbackText = nil
    }

    func checkPasswordAndDecrypt() {
        if let decrypted = CryptoManager.decrypt(encryptedText: message.encryptedText, base64Salt: message.salt, password: password) {
            feedbackText = String(localized: "resolver_correct_msg")
            
            Task {
                try? await Task.sleep(nanoseconds: 500_000_000)
                await MainActor.run {
                    onSuccess(decrypted)
                }
            }
        } else {
            feedbackText = String(localized: "resolver_incorrect_msg")
            password = ""
            Task {
                try? await Task.sleep(nanoseconds: 1_000_000_000)
                await MainActor.run {
                    withAnimation {
                        self.feedbackText = nil
                    }
                }
            }
        }
    }
}
