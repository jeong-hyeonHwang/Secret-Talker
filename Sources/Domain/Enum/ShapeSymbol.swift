//
//  ShapeSymbol.swift
//  SecretTalker
//
//  Created by 황정현 on 7/11/25.
//

import SwiftUI

enum ShapeSymbol: Int, CaseIterable, Identifiable {
    case circle = 0
    case triangle = 1
    case rectangle = 2
    
    var id: Int { rawValue }
    
    var shape: AnyShape {
        switch self {
        case .circle:
            return AnyShape(Circle())
        case .triangle:
            return AnyShape(PolygonShape(sides: 3))
        case .rectangle:
            return AnyShape(Rectangle())
        }
    }
    
    @ViewBuilder
    var view: some View {
        switch self {
        case .circle:
            Circle().stroke(lineWidth: 2)
        case .triangle:
            PolygonShape(sides: 3).stroke(lineWidth: 2)
        case .rectangle:
            Rectangle().stroke(lineWidth: 2)
        }
    }
    
    static func from(character: Character) -> ShapeSymbol? {
        switch character {
        case "0": return .circle
        case "1": return .triangle
        case "2": return .rectangle
        default: return nil
        }
    }
}
