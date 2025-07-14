//
//  ShapeWrapper.swift
//  SecretTalker
//
//  Created by 황정현 on 7/11/25.
//

import SwiftUI

struct AnyShape: Shape {
    private let pathBuilder: (CGRect) -> Path

    init<S: Shape>(_ shape: S) {
        self.pathBuilder = { rect in
            shape.path(in: rect)
        }
    }

    func path(in rect: CGRect) -> Path {
        pathBuilder(rect)
    }
}
