//
//  MessageRowItem.swift
//  SecretTalker
//
//  Created by 황정현 on 7/11/25.
//

import SwiftUI

struct MessageRowView: View {
    let message: CreatedSecretMessage
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(alignment: .leading, spacing: 0) {
                Text("\(message.salt)")
                    .font(.orbitronCaption)
                    .foregroundColor(.gray)
                    .padding(8)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .background(Color.clear)
    }
}
