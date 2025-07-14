//
//  ScannedSecretMessage.swift
//  SecretTalker
//
//  Created by 황정현 on 7/14/25.
//

import Foundation
import SwiftData

@Model
class ScannedSecretMessage: Identifiable {
    @Attribute(.unique) var id: UUID
    private(set) var encryptedText: String
    private(set) var salt: String
    private(set) var createdDate: Date
    private(set) var scannedDate: Date
    private(set) var unlockedDate: Date?
    private(set) var hint: String?
    
    init(id: UUID = UUID(), encryptedText: String, salt: String, createdDate: Date) {
        self.id = id
        self.encryptedText = encryptedText
        self.salt = salt
        self.createdDate = createdDate
        self.scannedDate = Date()
        self.unlockedDate = nil
        self.hint = nil
    }
    
    func isSolved() -> Bool {
        return unlockedDate != nil
    }
    
    func setAsSolved() {
        unlockedDate = Date()
    }
    
    func setHintAs(_ hint: String) {
        self.hint = hint
    }
}

extension ScannedSecretMessage: QRMessageEncodable {
    func asPayload() -> QRMessagePayload {
        QRMessagePayload(
            id: id,
            encryptedText: encryptedText,
            salt: salt,
            createdDate: createdDate
        )
    }
}
