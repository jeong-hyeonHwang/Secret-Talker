//
//  PolygonButton.swift
//  SecretTalker
//
//  Created by 황정현 on 5/31/25.
//

import SwiftUI

struct ShapeButton<Content: Shape>: View {
        let shape: Content
        let color: Color
        let action: () -> Void
        let ratio: CGFloat

        var body: some View {
            GeometryReader { geometry in
                let side = min(geometry.size.width, geometry.size.height) * ratio

                Button(action: action) {
                    shape
                        .fill(color)
                        .frame(width: side, height: side)
                        .overlay(shape.stroke(Color.black, lineWidth: 2))
                        .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
                }
            }
        }
    }
