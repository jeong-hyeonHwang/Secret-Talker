//
//  PasswordInputView.swift
//  SecretTalker
//
//  Created by 황정현 on 7/3/25.
//

import SwiftUI

struct PasswordInputView: View {
    @Environment(\.shapeButtonStyle) var style
    @Binding var password: String
    
    var body: some View {
        GeometryReader { geo in
            VStack(spacing: 8) {
                // 열쇠를 입력하라.
                Text(String(localized: "creator_write_password"))
                    .font(.orbitronHeadline)
                
                HStack(spacing: 16) {
                    ShapeButton(symbol: .circle, ratio: style.ratio, action: { appendPassword("\($0)") })
                    ShapeButton(symbol: .triangle, ratio: style.ratio, action: { appendPassword("\($0)") })
                    ShapeButton(symbol: .rectangle, ratio: style.ratio, action: { appendPassword("\($0)") })
                }
                .frame(height: geo.size.height * 0.25)
                
                HStack {
                    ScrollViewReader { proxy in
                        ScrollView {
                            FlowLayout(defaultSize: CGSize(width: 24, height: 24)) {
                                ForEach(Array(password.enumerated()), id: \.offset) { _, char in
                                    shapeView(for: char)
                                        .frame(width: 24, height: 24)
                                }
                            }
                            .frame(width: geo.size.width)
                            .padding(.top, 8)
                            
                            Color.clear
                                .frame(height: 1)
                                .id("BOTTOM")
                        }.frame(
                            height: geo.size.height * 0.75)
                        .onChange(of: password) {
                            // 패스워드가 변경될 때 스크롤 아래로 이동
                            withAnimation {
                                proxy.scrollTo("BOTTOM", anchor: .bottom)
                            }
                        }
                    }
                }.frame(width: geo.size.width)
            }
        }
    }
    
    @ViewBuilder
    private func shapeView(for char: Character) -> some View {
        if let symbol = ShapeSymbol.from(character: char) {
            symbol.view
        } else {
            EmptyView()
        }
    }
    
    private func appendPassword(_ val: String) {
        password += val
    }
}
