//
//  InputFeedbackView.swift
//  SecretTalker
//
//  Created by 황정현 on 7/3/25.
//

import SwiftUI

struct InputFeedbackView: View {
    @Binding var creationStatus: CreationStatus
    var body: some View {
        Text(creationStatus.instruction)
            .font(.orbitronSubheadline)
            .foregroundColor(creationStatus.color)
    }
}
