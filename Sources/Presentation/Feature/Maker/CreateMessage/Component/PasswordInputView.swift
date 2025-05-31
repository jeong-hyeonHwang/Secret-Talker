//
//  PasswordInputView.swift
//  SecretTalker
//
//  Created by 황정현 on 7/3/25.
//

import SwiftUI

struct PasswordInputView: View {
    @Binding var password: String
    
    var body: some View {
        GeometryReader { geo in
            VStack(spacing: 8) {
                // 열쇠를 입력하라.
                Text("Clave insere")
                    .font(.headline)
                
                HStack(spacing: 16) {
                    ShapeButton(shape: Circle(), color: .red, action: {
                        password += "0"
                    }, ratio: 0.6)
                    
                    ShapeButton(shape: PolygonShape(sides: 3), color: .green, action: {
                        password += "3"
                    }, ratio: 0.6)
                    
                    ShapeButton(shape: Rectangle(), color: .blue, action: {
                        password += "4"
                    }, ratio: 0.6)
                }
                .frame(height: geo.size.height * 0.25)
                
                HStack {
                    ScrollViewReader { proxy in
                        ScrollView {
                            FlowLayout() {
                                ForEach(Array(password.enumerated()), id: \.offset) { _, char in
                                    shapeView(for: char)
                                        .frame(width: 24, height: 24)
                                }
                            }
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding(.top, 8)
                            
                            Color.clear
                                .frame(height: 1)
                                .id("BOTTOM")
                        }.frame(height: geo.size.height * 0.75)
                            .onChange(of: password) { _ in
                                // 패스워드가 변경될 때 스크롤 아래로 이동
                                withAnimation {
                                    proxy.scrollTo("BOTTOM", anchor: .bottom)
                                }
                            }
                    }
                }
            }
        }
        
    }
    
    @ViewBuilder
    func shapeView(for char: Character) -> some View {
        switch char {
        case "0":
            Circle().stroke(lineWidth: 2)
        case "3":
            PolygonShape(sides: 3).stroke(lineWidth: 2)
        case "4":
            Rectangle().stroke(lineWidth: 2)
        default:
            EmptyView()
        }
    }
}

#Preview {
    PasswordInputView(password: State(initialValue: "").projectedValue)
}
