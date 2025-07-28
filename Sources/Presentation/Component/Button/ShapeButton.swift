//
//  PolygonButton.swift
//  SecretTalker
//
//  Created by 황정현 on 5/31/25.
//

import SwiftUI

struct ShapeButton: View {
    let symbol: ShapeSymbol
    let color: Color = Color.clear
    let ratio: CGFloat
    let action: (ShapeSymbol.ID) -> Void

    var body: some View {
        GeometryReader { geometry in
            let side = min(geometry.size.width, geometry.size.height) * ratio
            let origin = CGPoint(
                x: (geometry.size.width - side) / 2,
                y: (geometry.size.height - side) / 2
            )
            let frame = CGRect(origin: origin, size: CGSize(width: side, height: side))
            let shapePath = symbol.shape.path(in: frame)

            Button {
                action(symbol.id)
            } label: {
                symbol.shape
                    .fill(color)
                    .overlay(symbol.shape.stroke(Color.foregroundColor, lineWidth: 2))
                    .frame(width: side, height: side)
                    .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
            }
            .contentShape(shapePath)
        }
    }
}
