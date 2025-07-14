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
    @Environment(\.modelContext) private var modelContext
    
    @State private var isPresentingNew = false
    @State private var selectedMessage: CreatedSecretMessage?
    
    var body: some View {
        GeometryReader { geo in
            NavigationView {
                VStack(spacing: 4) {
                    Spacer(minLength: 4)
                    RotatingShapeButtonView()
                        .frame(height: geo.size.height * 0.38)
                    List {
                        ForEach(messages) { message in
                            MessageRowView(message: message) {
                                selectedMessage = message
                            }
//                            .listRowBackground(Color.clear) // 배경 투명화
                            .listRowInsets(EdgeInsets())
                        }
                        .onDelete(perform: delete)
                    }
                    .padding(.horizontal, -12)
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
                        QRView(message: message)
                            .presentationDetents([.medium, .large])
                            .presentationDragIndicator(.visible)
                    }
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
