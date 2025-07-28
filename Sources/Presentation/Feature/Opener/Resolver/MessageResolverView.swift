//
//  UnlockView.swift
//  SecretTalker
//
//  Created by 황정현 on 6/1/25.
//

import SwiftUI

struct MessageResolverView: View {
    @Environment(\.shapeButtonStyle) var style
    @StateObject private var viewModel: MessageResolverViewModel

    init(message: ScannedSecretMessage, onSuccess: @escaping (String) -> Void) {
        _viewModel = StateObject(wrappedValue: MessageResolverViewModel(message: message, onSuccess: onSuccess))
    }

    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                // 입력 영역
                VStack(spacing: 16) {
                    ShapeButton(symbol: .circle, ratio: style.ratio, action: { viewModel.appendPassword("\($0)") })
                    ShapeButton(symbol: .triangle, ratio: style.ratio, action: { viewModel.appendPassword("\($0)") })
                    ShapeButton(symbol: .rectangle, ratio: style.ratio, action: { viewModel.appendPassword("\($0)") })
                }
                .frame(height: geometry.size.height * 0.7)

                // 결과 영역
                VStack(spacing: 8) {
                    Spacer()
                    Group {
                        if viewModel.password.isEmpty {
                            Text(String(localized: "ph_enter_password"))
                                .foregroundColor(.gray)
                                .font(.orbitronTitle)
                                .italic()
                        } else {
                            Text(viewModel.password)
                                .foregroundColor(.primary)
                                .font(.orbitronTitle)
                        }
                    }

                    Text(viewModel.feedbackText ?? " ")
                        .foregroundColor(viewModel.feedbackText == String(localized: "resolver_correct_msg") ? .green : .red)
                        .font(.orbitronHeadline)
                        .opacity(viewModel.feedbackText == nil ? 0 : 1)
                        .fixedSize()
                        .animation(.easeInOut, value: viewModel.feedbackText)

                    Spacer()

                    RoundedShapeButton(
                        action: { viewModel.checkPasswordAndDecrypt() },
                        title: String(localized: "btn_submit")
                    )
                    .padding(.horizontal)

                    Button(String(localized: "btn_clear")) {
                        viewModel.clear()
                    }
                }
                .frame(height: geometry.size.height * 0.3, alignment: .top)
            }
        }
    }
}
