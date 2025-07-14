//
//  RotatingShapeButtonView.swift
//  SecretTalker
//
//  Created by 황정현 on 7/11/25.
//

import SwiftUI

struct RotatingShapeButtonView: View {
    var shapeRatio: CGFloat = 0.4
    let radius: CGFloat = 80

    var body: some View {
        TimelineView(.animation) { timeline in
            let time = timeline.date.timeIntervalSinceReferenceDate
            let rotationPeriod: Double = 30
            let angle = Angle.degrees((time.truncatingRemainder(dividingBy: rotationPeriod)) / rotationPeriod * 360)

            VStack {
                ZStack {
                    ForEach(ShapeType.allCases, id: \.rawValue) { shapeType in
                        let index = shapeType.rawValue
                        let baseAngle = Angle.degrees(Double(index) * 120)
                        let totalAngle = angle + baseAngle
                        let shape = AnyShape(shapeType.shape())

                        ShapeButton(shape: shape, action: {}, ratio: shapeRatio)
                            .offset(
                                x: radius * cos(CGFloat(totalAngle.radians)),
                                y: radius * sin(CGFloat(totalAngle.radians))
                            )
                    }.frame(width: radius * 2 + 100, height: radius * 2 + 100)
                }.rotationEffect(angle)
            }
            
        }
    }
}
