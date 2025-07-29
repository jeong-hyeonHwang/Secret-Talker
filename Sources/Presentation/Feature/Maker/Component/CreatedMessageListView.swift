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
            ForEach(Array(messages.enumerated()), id: \.element.id) { index, message in
                let displayIndex = messages.count - index

                MessageRowItem(
                    message: message,
                    content: "Rec \(displayIndex) - \(message.createdDate.displayDateTimeString())"
                ) { message in
                    makerViewModel.selectedMessage = message
                }
                .listRowBackground(Color.clear)
                .listRowInsets(EdgeInsets())
            }

            .onDelete(perform: { offsets in
                makerViewModel.delete(messages: messages, at: offsets) })
        }
    }
}
