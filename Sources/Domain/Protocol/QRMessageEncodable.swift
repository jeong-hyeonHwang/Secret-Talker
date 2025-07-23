//
//  QRMessageEncodable.swift
//  SecretTalker
//
//  Created by 황정현 on 7/15/25.
//

protocol QRMessageEncodable: Identifiable {
    func asPayload() -> QRMessagePayload
}
