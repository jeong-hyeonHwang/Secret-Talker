//
//  MessageViewModel.swift
//  SecretTalker
//
//  Created by 황정현 on 7/3/25.
//

import Foundation
import Combine

final class MessageViewModel: ObservableObject {
    @Published var message: String
    @Published var password: String
    @Published var feedbackText: String
    @Published var creationStatus: CreationStatus
    
    init() {
        message = ""
        password = ""
        feedbackText = ""
        creationStatus = .common
    }
    
    func isCreationAvailable() -> Bool {
        if message.isEmpty {
            creationStatus = .emptyMessage
            return false
        } else if password.isEmpty {
            creationStatus = .emptyPassword
            return false
        }
        return true
    }
    
    func encryptedMessage() -> (encryptedText: String, salt: String)? {
        guard let encrypted = CryptoManager.encrypt(message: message, password: password) else {
            creationStatus = .failedEncryption
            return nil
        }
        return encrypted
    }
    
    func createMessage() -> CreatedSecretMessage? {
            guard isCreationAvailable() else { return nil }
            guard let result = encryptedMessage() else { return nil }

            return CreatedSecretMessage(
                id: UUID(),
                encryptedText: result.encryptedText,
                salt: result.salt
            )
        }
}
