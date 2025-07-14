//
//  QRMessagePayload.swift
//  SecretTalker
//
//  Created by 황정현 on 6/1/25.
//

import Foundation.NSDate

struct QRMessagePayload: Codable, Identifiable {
    let id: UUID
    let encryptedText: String
    let salt: String
    let createdDate: Date
    
    init (id: UUID, encryptedText: String, salt: String, createdDate: Date = Date()) {
        self.id = id
        self.encryptedText = encryptedText
        self.salt = salt
        self.createdDate = createdDate
    }
}
