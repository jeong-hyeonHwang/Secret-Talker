//
//  ReceivedMessageListView.swift
//  SecretTalker
//
//  Created by 황정현 on 6/1/25.
//

import SwiftUI

struct ReceivedMessageListView: View {
    let qrList: [ScannedSecretMessage]
    
    @GestureState private var dragOffset = CGSize.zero
    
    @Environment(\.modelContext) private var modelContext
    var body: some View {
        List {
            ForEach(qrList) { message in
                Text("\(message.createdDate)")
                .listRowBackground(Color.clear)
                .listRowInsets(EdgeInsets())
            }
            .onDelete(perform: delete)
        }
    }
    
    func delete(at offsets: IndexSet) {
        for index in offsets {
            modelContext.delete(qrList[index])
        }
    }
}
