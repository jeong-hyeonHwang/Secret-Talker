//
//  PolygonButton.swift
//  SecretTalker
//
//  Created by 황정현 on 5/31/25.
//

import SwiftUI

struct ShapeButton<S: Shape>: View {
    let shape: S
    var color: Color = .clear
    let action: () -> Void
    let ratio: CGFloat

    var body: some View {
        GeometryReader { geometry in
            let side = min(geometry.size.width, geometry.size.height) * ratio
            let origin = CGPoint(
                x: (geometry.size.width - side) / 2,
                y: (geometry.size.height - side) / 2
            )
            let frame = CGRect(origin: origin, size: CGSize(width: side, height: side))
            let shapePath = shape.path(in: frame)

            ZStack {
                Button(action: action) {
                    shape
                        .fill(color)
                        .overlay(shape.stroke(Color.foregroundColor, lineWidth: 2))
                        .frame(width: side, height: side)
                        .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
                }
                .contentShape(shapePath)
                .frame(width: geometry.size.width, height: geometry.size.height)
            }
        }
    }
}
