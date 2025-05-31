//
//  OpenerView.swift
//  SecretTalker
//
//  Created by 황정현 on 6/1/25.
//

import AVFoundation
import SwiftData
import SwiftUI

import AVFoundation
import SwiftData
import SwiftUI

struct OpenerView: View {
    @Query var qrHistory: [SecretMessage]
    @Environment(\.modelContext) private var modelContext
    @Environment(\.scenePhase) private var scenePhase
    
    @State private var isSheetExpanded = false
    @StateObject private var cameraManager = CameraManager()
    
    @State private var scannedPassword: String? = nil
    @State private var scannedSecret: SecretMessage?
    @State private var decryptedText: String? = nil
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
        .onChange(of: cameraManager.scannedCode?.id) { code in
            guard
                let scanned = cameraManager.scannedCode,
                let data = scanned.code.data(using: .utf8),
                let payload = try? JSONDecoder().decode(QRPayload.self, from: data)
            else {
                print("QR 디코딩 실패")
                return
            }
            let secretMessage = SecretMessage(
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
        .sheet(item: $scannedSecret) { message in
            UnlockView(message: message) { decrypted in
                Task {
                    await MainActor.run {
                        modelContext.insert(message)
                        decryptedText = decrypted
                        isShowingSuccessMessage = true
                        scannedSecret = nil
                    }
                }
            }
        }
        .sheet(isPresented: $isShowingSuccessMessage) {
            if let decryptedText {
                MessageView(isPresented: $isShowingSuccessMessage, message: decryptedText)
            }
        }
    }
}
