//
//  UnlockView.swift
//  SecretTalker
//
//  Created by 황정현 on 6/1/25.
//

import SwiftUI

public struct MessageResolverView: View {
    let message: ScannedSecretMessage
    let onSuccess: (String) -> Void
    
    @State private var shapeRatio = 0.7
    @State private var password = ""
    @State private var feedbackText: String?
    
    public var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                // 입력 영역
                VStack(spacing: 16) {
                    ShapeButton(shape: Circle(), action: {
                        password += "0"
                    }, ratio: shapeRatio)
                    ShapeButton(shape: PolygonShape(sides: 3), action: {
                        password += "1"
                    }, ratio: shapeRatio)
                    ShapeButton(shape: Rectangle(), action: {
                        password += "2"
                    }, ratio: shapeRatio)
                }
                .frame(height: geometry.size.height * 0.7)
                
                // 결과 영역
                VStack(spacing: 8) {
                    Spacer()
                    Group {
                        if password.isEmpty {
                            Text("ENTER PASSWORD")
                                .foregroundColor(.gray)
                                .font(.orbitronTitle)
                                .italic()
                        } else {
                            Text(password)
                                .foregroundColor(.primary)
                                .font(.orbitronTitle)
                        }
                    }
                    
                    Text(feedbackText ?? " ")
                        .foregroundColor(feedbackText == "Rectum est." ? .green : .red)
                        .font(.orbitronHeadline)
                        .opacity(feedbackText == nil ? 0 : 1)
                        .fixedSize()
                        .animation(.easeInOut, value: feedbackText)
                    
                    Spacer()
                    
                    RoundedShapeButton(
                        action: { checkPasswordAndDecrypt() },
                        title: "Mitte"
                    )
                    .padding(.horizontal)
                    
                    Button("Clear") {
                        password = ""
                        feedbackText = nil
                    }
                }
                .frame(height: geometry.size.height * 0.3, alignment: .top)
            }
        }
    }
    
    private func checkPasswordAndDecrypt() {
        if let decrypted = CryptoManager.decrypt(encryptedText: message.encryptedText, base64Salt: message.salt, password: password) {
            feedbackText = "Rectum est."
            Task {
                try? await Task.sleep(nanoseconds: 500_000_000)
                await MainActor.run {
                    onSuccess(decrypted)
                }
            }
        } else {
            feedbackText = "Falsum est."
            password = ""
            Task {
                try? await Task.sleep(nanoseconds: 1_000_000_000)
                await MainActor.run {
                    withAnimation {
                        feedbackText = nil
                    }
                }
            }
        }
    }
}
