//
//  MessageListView.swift
//  SecretTalker
//
//  Created by 황정현 on 6/1/25.
//

import SwiftUI
import SwiftData

struct MakerView: View {
    @Query var messages: [SecretMessage]
    @Environment(\.modelContext) private var modelContext
    
    @State private var isPresentingNew = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(messages) { message in
                    NavigationLink(destination: QRView(message: message)) {
                        VStack(alignment: .leading) {
                            Text("🔒 \(message.salt)")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                    }
                }
                .onDelete(perform: delete)
            }
            .navigationTitle("Verba arcana")
            .toolbar {
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
        }
    }
    
    func delete(at offsets: IndexSet) {
        for index in offsets {
            modelContext.delete(messages[index])
        }
    }
}
