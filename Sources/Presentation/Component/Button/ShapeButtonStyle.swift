//
//  ShapeButtonStyle.swift
//  SecretTalker
//
//  Created by 황정현 on 7/28/25.
//

import SwiftUI

struct ShapeButtonStyle {
    let ratio: CGFloat
}

struct ShapeButtonStyleKey: EnvironmentKey {
    static let defaultValue = ShapeButtonStyle(ratio: 0.7)
}

extension EnvironmentValues {
    var shapeButtonStyle: ShapeButtonStyle {
        get { self[ShapeButtonStyleKey.self] }
        set { self[ShapeButtonStyleKey.self] = newValue }
    }
}
