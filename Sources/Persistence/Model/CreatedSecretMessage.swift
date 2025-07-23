//
//  SecretMessage.swift
//  SecretTalker
//
//  Created by 황정현 on 6/1/25.
//

import Foundation
import SwiftData

@Model
class CreatedSecretMessage: Identifiable {
    @Attribute(.unique) var id: UUID
    private(set) var encryptedText: String
    private(set) var salt: String
    private(set) var createdDate: Date
    
    init(id: UUID = UUID(), encryptedText: String, salt: String) {
        self.id = id
        self.encryptedText = encryptedText
        self.salt = salt
        self.createdDate = Date()
    }
}

extension CreatedSecretMessage: QRMessageEncodable {
    func asPayload() -> QRMessagePayload {
        QRMessagePayload(
            id: id,
            encryptedText: encryptedText,
            salt: salt,
            createdDate: createdDate
        )
    }
}
