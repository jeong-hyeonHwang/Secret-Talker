//
//  MessageView.swift
//  SecretTalker
//
//  Created by 황정현 on 6/1/25.
//

import SwiftUI

struct MessageView: View {
    var message: DecryptedMessage

    var body: some View {
        VStack {
            Text("\(message.decryptedText)")
                .font(.orbitronLargeTitle)
                .bold()
                .foregroundColor(.foregroundColor)
        }
    }
}
