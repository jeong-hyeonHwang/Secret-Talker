//
//  SecretMessage.swift
//  SecretTalker
//
//  Created by 황정현 on 6/1/25.
//

import Foundation
import SwiftData

@Model
class SecretMessage: Identifiable {
    @Attribute(.unique) var id: UUID
    var encryptedText: String
    var salt: String
    
    init(id: UUID = UUID(), encryptedText: String, salt: String) {
        self.id = id
        self.encryptedText = encryptedText
        self.salt = salt
    }
}
