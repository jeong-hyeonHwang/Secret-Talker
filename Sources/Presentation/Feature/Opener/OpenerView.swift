//
//  OpenerView.swift
//  SecretTalker
//
//  Created by 황정현 on 6/1/25.
//

import AVFoundation
import SwiftData
import SwiftUI

struct OpenerView: View {
    @Query var qrHistory: [CreatedSecretMessage]
    @Environment(\.modelContext) private var modelContext
    @Environment(\.scenePhase) private var scenePhase
    
    @State private var isSheetExpanded = false
    @StateObject private var cameraManager = CameraManager()
    
    @State private var scannedPassword: String?
    @State private var scannedSecret: CreatedSecretMessage?
    @State private var decryptedText: String?
    @State private var isShowingSuccessMessage = false
    
    var body: some View {
        ZStack {
            CameraPreviewView(session: cameraManager.session)
                .ignoresSafeArea()
                .opacity(isSheetExpanded ? 0.2 : 1)
            
            ReceivedMessageListView(
                isExpanded: $isSheetExpanded,
                qrList: qrHistory,
                onExpandChanged: { expanded in
                    if expanded {
                        cameraManager.pause()
                    } else {
                        cameraManager.resume()
                    }
                }
            )
        }
        .onAppear {
            cameraManager.configure()
        }
        .onChange(of: cameraManager.scannedCode?.id) { _ in
            guard
                let scanned = cameraManager.scannedCode,
                let data = scanned.code.data(using: .utf8),
                let payload = try? JSONDecoder().decode(QRPayload.self, from: data)
            else {
                print("QR 디코딩 실패")
                return
            }
            let secretMessage = CreatedSecretMessage(
                encryptedText: payload.encryptedText,
                salt: payload.salt)
            
            scannedSecret = secretMessage
        }
        .onChange(of: scenePhase) { newPhase in
            if newPhase == .active {
                cameraManager.resume()
            } else {
                cameraManager.pause()
            }
        }
        .sheet(item: $scannedSecret, onDismiss: {
            if !isShowingSuccessMessage {
                cameraManager.resume()
            }
        }) { message in
            UnlockView(message: message) { decrypted in
                Task {
                    cameraManager.pause()
                    await MainActor.run {
                        modelContext.insert(message)
                        decryptedText = decrypted
                        isShowingSuccessMessage = true
                        scannedSecret = nil
                    }
                }
            }
        }
        .sheet(isPresented: $isShowingSuccessMessage, onDismiss: {
            if !isShowingSuccessMessage {
                cameraManager.resume()
            }
        }) {
            if let decryptedText {
                MessageView(isPresented: $isShowingSuccessMessage, message: decryptedText)
            }
        }
    }
}
