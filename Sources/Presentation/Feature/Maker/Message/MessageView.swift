//
//  MessageView.swift
//  SecretTalker
//
//  Created by 황정현 on 6/1/25.
//

import SwiftUI

struct MessageView: View {
    @Binding var isPresented: Bool
    var message: String

    var body: some View {
        ZStack {
            Color.green.opacity(0.9).ignoresSafeArea()
            VStack(spacing: 20) {
                Text(message)
                    .font(.orbitronLargeTitle)
                    .bold()
                    .foregroundColor(.backgroundColor)

                Button(action: { isPresented = false }) {
                    Text("Dismiss")
                        .font(.orbitronHeadline)
                        .padding()
                        .background(Color.backgroundColor)
                        .cornerRadius(10)
                }
            }
        }
    }
}
