//
//  MessageRowItem.swift
//  SecretTalker
//
//  Created by 황정현 on 7/11/25.
//

import SwiftUI

struct MessageRowView<T: QRMessageEncodable>: View {
    let message: T
    let content: String
    let action: (_ message: T) -> Void

    var body: some View {
        Button(action: {
            action(message)
        }) {
            VStack(alignment: .leading, spacing: 0) {
                Text("\(content)")
                    .font(.orbitronCaption)
                    .foregroundColor(.gray)
                    .padding(8)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .background(Color.clear)
    }
}
