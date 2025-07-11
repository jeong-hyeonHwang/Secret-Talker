//
//  RoundedShapeButton.swift
//  SecretTalker
//
//  Created by 황정현 on 6/1/25.
//

import SwiftUI

struct RoundedShapeButton: View {
    var color: Color = Color.backgroundColor
    let action: () -> Void
    let title: String
    let cornerRadius: CGFloat = 10

    var body: some View {
        Button(action: action) {
            Text(title)
                .foregroundColor(.foregroundColor)
                .bold()
                .frame(height: 50)
                .frame(maxWidth: .infinity)
                .background(
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .fill(color)
                )
                .overlay(
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .stroke(Color.foregroundColor, lineWidth: 2)
                )
        }
    }
}
