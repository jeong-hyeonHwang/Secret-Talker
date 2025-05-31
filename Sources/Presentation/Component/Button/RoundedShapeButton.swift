//
//  RoundedShapeButton.swift
//  SecretTalker
//
//  Created by 황정현 on 6/1/25.
//

import SwiftUI

struct RoundedShapeButton: View {
    let color: Color
    let action: () -> Void
    let title: String
    let cornerRadius: CGFloat

    var body: some View {
        Button(action: action) {
            Text(title)
                .foregroundColor(.white)
                .bold()
                .frame(height: 50)
                .frame(maxWidth: .infinity)
                .background(
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .fill(color)
                )
                .overlay(
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .stroke(Color.black.opacity(0.2), lineWidth: 1)
                )
        }
    }
}
