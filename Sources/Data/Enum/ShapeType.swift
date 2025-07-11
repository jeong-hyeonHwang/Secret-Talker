//
//  ShapeType.swift
//  SecretTalker
//
//  Created by 황정현 on 7/11/25.
//

import SwiftUI

enum ShapeType: Int, CaseIterable {
    case circle = 0
    case triangle = 1
    case rectangle = 2

    func shape(sides: Int = 3) -> any Shape {
            switch self {
            case .circle:
                return Circle()
            case .triangle:
                return PolygonShape(sides: sides)
            case .rectangle:
                return Rectangle()
            }
        }
}
