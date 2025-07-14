//
//  ReceivedMessageListView.swift
//  SecretTalker
//
//  Created by 황정현 on 6/1/25.
//

import SwiftUI

struct ReceivedMessageListView: View {
    @Binding var isExpanded: Bool
    let qrList: [CreatedSecretMessage]
    var onExpandChanged: ((Bool) -> Void)?
    
    @GestureState private var dragOffset = CGSize.zero
    
    @Environment(\.modelContext) private var modelContext
    var body: some View {
        let dragGesture = DragGesture()
            .updating($dragOffset) { value, state, _ in
                state = value.translation
            }
            .onEnded { value in
                if value.translation.height < -100 {
                    isExpanded = true
                    onExpandChanged?(true)
                } else if value.translation.height > 100 {
                    isExpanded = false
                    onExpandChanged?(false)
                }
            }
        
        VStack {
            Capsule()
                .frame(width: 40, height: 6)
                .foregroundColor(.gray)
                .padding(8)
            
            Text("스캔 기록")
                .font(.orbitronHeadline)
            
            List {
                Section {
                    ForEach(qrList) { qr in
                        Text(qr.encryptedText.prefix(24) + "…")
                    }.onDelete(perform: delete)
                }.listStyle(DefaultListStyle())
            }
        }
        .frame(maxHeight: isExpanded ? .infinity : 240)
        .background(.ultraThinMaterial)
        .cornerRadius(16)
        .offset(y: isExpanded ? 0 : UIScreen.main.bounds.height * 0.5)
        .animation(.easeInOut, value: isExpanded)
        .gesture(dragGesture)
    }
    
    func delete(at offsets: IndexSet) {
        for index in offsets {
            modelContext.delete(qrList[index])
        }
    }
}
