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

        let center = CGPoint(x: rect.midX, y: rect.midY)
        let correction: CGFloat = (sides == 3) ? 1.15 : 1.0
        let radius = min(rect.width, rect.height) / 2
        let angle = 2 * .pi / CGFloat(sides)

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
