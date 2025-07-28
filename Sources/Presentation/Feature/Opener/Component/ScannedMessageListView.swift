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
            ForEach(messages) { message in
                MessageRowItem(
                    message: message,
                    content: "\(message.scannedDate)"
                ) { openerViewModel.scannedMessage = $0 }
                .listRowBackground(Color.clear)
                .listRowInsets(EdgeInsets())
            }
            .onDelete(perform: { offsets in
                openerViewModel.delete(messages: messages, at: offsets) })
        }
        .background(Color.backgroundColor)
    }
}
