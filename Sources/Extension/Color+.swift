//
//  Color+.swift
//  SecretTalker
//
//  Created by 황정현 on 7/11/25.
//

import SwiftUICore

extension Color {
    enum CustomColor {
        case foregroundColor
        case backgroundColor
        
        var value: String {
            switch self {
            case .foregroundColor:
                return "ForegroundColor"
            case .backgroundColor:
                return "BackgroundColor"
            }
        }
    }
    
    static func color(_ customColor: CustomColor) -> Color {
        return Color(customColor.value)
    }
}

extension Color {
    static var foregroundColor: Color {
        return .color(.foregroundColor)
    }
    
    static var backgroundColor: Color {
        return .color(.backgroundColor)
    }
}

