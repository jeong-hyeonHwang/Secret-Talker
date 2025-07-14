//
//  PolygonShape.swift
//  SecretTalker
//
//  Created by 황정현 on 5/31/25.
//

import SwiftUI

struct PolygonShape: Shape {
    var sides: Int

    func path(in rect: CGRect) -> Path {
        guard sides >= 3 else { return Path() }

        var center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = min(rect.width, rect.height) / 2
        let angle = 2 * .pi / CGFloat(sides)

        // 삼각형 보정
        if sides == 3 {
            let side = 2 * radius * sin(.pi / 3)
            let height = side * sqrt(3) / 2
            let correction = height / 3
            center.y += correction
        }

        var path = Path()
        for i in 0..<sides {
            let x = center.x + radius * cos(CGFloat(i) * angle - .pi / 2)
            let y = center.y + radius * sin(CGFloat(i) * angle - .pi / 2)
            if i == 0 {
                path.move(to: CGPoint(x: x, y: y))
            } else {
                path.addLine(to: CGPoint(x: x, y: y))
            }
        }

        path.closeSubpath()
        return path
    }
}

