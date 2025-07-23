//
//  OpenerViewModel.swift
//  SecretTalker
//
//  Created by 황정현 on 7/23/25.
//

import Combine
import SwiftUI
import SwiftData

final class OpenerViewModel: ObservableObject {
    private let modelContext: ModelContext

    @Published var scannedMessage: ScannedSecretMessage?
    @Published var decryptedMessage: DecryptedMessage?
    @Published var isShowingSuccessMessage = false
    @Published var roiFrame: CGRect = .zero

    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }

    func handleScannedCode(_ code: String) {
        guard let data = code.data(using: .utf8),
              let payload = try? JSONDecoder().decode(QRMessagePayload.self, from: data) else {
            print("QR 디코딩 실패")
            return
        }

        let message = ScannedSecretMessage(
            encryptedText: payload.encryptedText,
            salt: payload.salt,
            createdDate: payload.createdDate
        )

        scannedMessage = message
        modelContext.insert(message)
    }

    func onSuccess(_ message: ScannedSecretMessage, decryptedText: String) {
        message.setAsSolved()
        decryptedMessage = DecryptedMessage(id: message.id, decryptedText: decryptedText)
        scannedMessage = nil
        isShowingSuccessMessage = true
    }

    func delete(messages: [ScannedSecretMessage], at offsets: IndexSet) {
        for index in offsets {
            modelContext.delete(messages[index])
        }
    }
    
    func setROIFrame(frame: CGRect) {
        roiFrame = frame
    }
}
