//
//  Untitled.swift
//  SecretTalker
//
//  Created by 황정현 on 7/3/25.
//

import SwiftUI

enum CreationStatus {
    case common
    case emptyMessage
    case emptyPassword
    case invalidMessage
    case invalidPassword
    case failedEncryption
}

extension CreationStatus: Status {
    var instruction: String {
        switch self {
        case .common:
            return ""
        case .emptyMessage:
            return String(localized: "error_empty_message")
        case .emptyPassword:
            return String(localized: "error_empty_password")
        case .invalidMessage:
            return String(localized: "error_invalid_message")
        case .invalidPassword:
            return String(localized: "error_invalid_password")
        case .failedEncryption:
            return String(localized: "error_failed_encryption")
        }
    }
    
    var color: Color {
        switch self {
        case .common:
            return .clear
        case .emptyMessage, .emptyPassword, .invalidMessage, .invalidPassword, .failedEncryption:
            return .red
        }
    }
}
