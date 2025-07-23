//
//  MessageListView.swift
//  SecretTalker
//
//  Created by 황정현 on 6/1/25.
//

import SwiftUI
import SwiftData

struct MakerView: View {
    @Environment(\.modelContext) private var modelContext
    
    @Query var messages: [CreatedSecretMessage]
    
    @State private var isPresentingNew = false
    @State private var selectedMessage: CreatedSecretMessage?
    
    var body: some View {
        GeometryReader { geo in
            VStack(spacing: 4) {
                Spacer(minLength: 4)
                RotatingShapeButtonView()
                    .frame(height: geo.size.height * 0.38)
                List {
                    ForEach(messages) { message in
                        MessageRowItem(
                            message: message,
                            content: "\(message.createdDate)") {
                            selectedMessage = $0
                        }
                        .listRowBackground(Color.clear)
                        .listRowInsets(EdgeInsets())
                    }
                    .onDelete(perform: delete)
                }
                .frame(height: geo.size.height * 0.62)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Text("Verba arcana")
                            .font(.orbitronTitle)
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            isPresentingNew = true
                        } label: {
                            Image(systemName: "plus")
                        }
                    }
                }
                .sheet(isPresented: $isPresentingNew) {
                    let viewModel = MessageViewModel()
                    CreateMessageView(messageViewModel: viewModel) { newMessage in
                        modelContext.insert(newMessage)
                    }
                }
                .sheet(item: $selectedMessage) { message in
                    QRView(qrPayload: message.asPayload())
                        .presentationDetents([.medium, .large])
                        .presentationDragIndicator(.visible)
                }
            }
            .scrollContentBackground(.hidden)
        }
    }
    
    func delete(at offsets: IndexSet) {
        for index in offsets {
            modelContext.delete(messages[index])
        }
    }
}
