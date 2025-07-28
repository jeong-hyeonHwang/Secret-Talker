//
//  MessageListView.swift
//  SecretTalker
//
//  Created by 황정현 on 6/1/25.
//

import SwiftUI
import SwiftData

struct MakerView: View {
    @Query var messages: [CreatedSecretMessage]
    
    @StateObject private var makerViewModel: MakerViewModel
    
    init(modelContext: ModelContext) {
        _makerViewModel = StateObject(wrappedValue: MakerViewModel(modelContext: modelContext))
    }
    
    var body: some View {
        GeometryReader { geo in
            VStack(spacing: 4) {
                Spacer(minLength: 4)
                
                RotatingShapeButtonView()
                    .frame(height: geo.size.height * 0.38)
                    .environment(\.shapeButtonStyle, ShapeButtonStyle(ratio: 0.4))
                CreatedMessageListView(
                    messages: messages,
                    makerViewModel: makerViewModel
                )
                .frame(height: geo.size.height * 0.62)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Text(String(localized: "maker_title"))
                            .font(.orbitronTitle)
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            makerViewModel.isPresentingNew = true
                        } label: {
                            Image(systemName: "plus")
                        }
                    }
                }
                .sheet(isPresented: $makerViewModel.isPresentingNew) {
                    let viewModel = MessageViewModel()
                    CreateMessageView(messageViewModel: viewModel) { newMessage in
                        makerViewModel.insert(newMessage)
                    }
                }
                .sheet(item: $makerViewModel.selectedMessage) { message in
                    QRView(qrPayload: message.asPayload())
                        .presentationDetents([.medium, .large])
                        .presentationDragIndicator(.visible)
                }
            }
            .scrollContentBackground(.hidden)
        }
    }
}
