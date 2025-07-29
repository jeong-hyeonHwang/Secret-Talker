//
//  ScannedMessageListView.swift
//  SecretTalker
//
//  Created by 황정현 on 6/1/25.
//

import SwiftUI

struct ScannedMessageListView: View {
    let messages: [ScannedSecretMessage]
    let openerViewModel: OpenerViewModel

    var body: some View {
        List {
            ForEach(Array(messages.enumerated()), id: \.element.id) { index, message in
                let displayIndex = messages.count - index

                MessageRowItem(
                    message: message,
                    content: "REC \(displayIndex): \(message.createdDate.displayDateTimeString())"
                ) { message in
                    openerViewModel.scannedMessage = message
                }
                .listRowBackground(Color.clear)
                .listRowInsets(EdgeInsets())
            }
            .onDelete(perform: { offsets in
                openerViewModel.delete(messages: messages, at: offsets) })
        }
        .background(Color.backgroundColor)
    }
}
