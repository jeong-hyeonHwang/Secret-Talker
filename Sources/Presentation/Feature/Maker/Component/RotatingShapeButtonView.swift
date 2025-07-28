//
//  RotatingShapeButtonView.swift
//  SecretTalker
//
//  Created by 황정현 on 7/11/25.
//

import SwiftUI

struct RotatingShapeButtonView: View {
    @Environment(\.shapeButtonStyle) var style
    let radius: CGFloat = 80

    var body: some View {
        TimelineView(.animation) { timeline in
            let time = timeline.date.timeIntervalSinceReferenceDate
            let angle = Angle.degrees((time.truncatingRemainder(dividingBy: 30)) / 30 * 360)

            ZStack {
                ForEach(ShapeSymbol.allCases, id: \.rawValue) { symbol in
                    let index = symbol.rawValue
                    let baseAngle = Angle.degrees(Double(index) * 120)
                    let totalAngle = angle + baseAngle

                    shapeButton(for: symbol, angle: totalAngle)
                }
            }
            .frame(width: radius * 2 + 100, height: radius * 2 + 100)
            .rotationEffect(angle)
        }
    }
    
    @ViewBuilder
    func shapeButton(for symbol: ShapeSymbol, angle: Angle) -> some View {
        ShapeButton(symbol: symbol, ratio: style.ratio, action: { _ in })
            .offset(
                x: radius * cos(CGFloat(angle.radians)),
                y: radius * sin(CGFloat(angle.radians))
            )
    }
}
