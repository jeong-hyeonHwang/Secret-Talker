//
//  CreatedMessageListView.swift
//  SecretTalker
//
//  Created by 황정현 on 7/28/25.
//

import SwiftUI

struct CreatedMessageListView: View {
    let messages: [CreatedSecretMessage]
    let makerViewModel: MakerViewModel

    var body: some View {
        List {
            ForEach(messages) { message in
                MessageRowItem(
                    message: message,
                    content: "\(message.createdDate)"
                ) { makerViewModel.selectedMessage = $0 }
                .listRowBackground(Color.clear)
                .listRowInsets(EdgeInsets())
            }
            .onDelete(perform: { offsets in
                makerViewModel.delete(messages: messages, at: offsets) })
        }
        .background(Color.backgroundColor)
    }
}
