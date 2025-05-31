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
            return "메시지를 입력해주세요."
        case .emptyPassword:
            return "비밀번호를 입력해주세요."
        case .invalidMessage:
            return "불가능한 메시지입니다."
        case .invalidPassword:
            return "불가능한 비밀번호입니다."
        case .failedEncryption:
            return "암호화에 실패했습니다."
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
