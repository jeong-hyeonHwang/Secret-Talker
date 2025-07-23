//
//  DecryptedMessage.swift
//  SecretTalker
//
//  Created by 황정현 on 7/22/25.
//

import Foundation

struct DecryptedMessage: Identifiable {
    let id: UUID
    let decryptedText: String
}
