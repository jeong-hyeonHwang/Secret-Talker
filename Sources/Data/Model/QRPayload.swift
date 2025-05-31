//
//  QRPayload.swift
//  SecretTalker
//
//  Created by 황정현 on 6/1/25.
//

struct QRPayload: Codable {
    let encryptedText: String
    let salt: String
}
