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
    @Environment(\.modelContext) private var modelContext
    @Environment(\.scenePhase) private var scenePhase

    @Query var messages: [ScannedSecretMessage]

    @StateObject private var cameraManager = CameraManager()

    @State private var scannedMessage: ScannedSecretMessage?
    @State private var decryptedMessage: DecryptedMessage?
    @State private var isShowingSuccessMessage = false

    @State private var roiFrame: CGRect = .zero

    var body: some View {
        GeometryReader { geo in
            VStack(spacing: 4) {
                Spacer(minLength: 4)
                ZStack {
                    GeometryReader { proxy in
                        CameraPreviewView(session: cameraManager.session)
                            .onAppear {
                                updateROI(proxy: proxy)
                            }
                            .background(Color.clear)

                        /* ROI 시각화 오버레이
                        Rectangle()
                            .stroke(Color.green, lineWidth: 2)
                            .frame(width: roiFrame.width, height: roiFrame.height)
                            .position(x: roiFrame.midX, y: roiFrame.midY)
                        */
                    }
                }
                .frame(height: geo.size.height * 0.42)
                .clipped()

                List {
                    ForEach(messages) { message in
                        MessageRowItem(
                            message: message,
                            content: "\(message.scannedDate)"
                        ) {
                            scannedMessage = $0
                        }
                        .listRowBackground(Color.clear)
                        .listRowInsets(EdgeInsets())
                    }
                    .onDelete(perform: delete)
                }
                .background(Color.backgroundColor)
                .frame(height: geo.size.height * 0.58)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Text("Verba decodite")
                            .font(.orbitronTitle)
                    }
                }
            }
            .scrollContentBackground(.hidden)
        }
        .onAppear {
            cameraManager.configure()
        }
        .onChange(of: cameraManager.scannedCode?.id) { _ in
            guard
                let scanned = cameraManager.scannedCode,
                let data = scanned.code.data(using: .utf8),
                let payload = try? JSONDecoder().decode(QRMessagePayload.self, from: data)
            else {
                print("QR 디코딩 실패")
                return
            }
            let scannedSecretMessage = ScannedSecretMessage(
                encryptedText: payload.encryptedText,
                salt: payload.salt,
                createdDate: payload.createdDate
            )

            scannedMessage = scannedSecretMessage
            modelContext.insert(scannedSecretMessage)
        }
        .onChange(of: scenePhase) { newPhase in
            if newPhase == .active {
                cameraManager.resume()
            } else {
                cameraManager.pause()
            }
        }
        .sheet(item: $scannedMessage, onDismiss: {
            if !isShowingSuccessMessage {
                cameraManager.resume()
            }
        }) { message in
            MessageResolverView(
                message: message,
                onSuccess: { decryptedText in
                    Task {
                        cameraManager.pause()
                        await MainActor.run {
                            message.setAsSolved()
                            self.decryptedMessage = DecryptedMessage(
                                id: message.id,
                                decryptedText: decryptedText
                            )
                            self.scannedMessage = nil
                            self.isShowingSuccessMessage = true
                        }
                    }
                }
            )
        }
        .sheet(item: $decryptedMessage, onDismiss: {
            cameraManager.resume()
        }) { message in
            MessageView(message: message)
        }
    }

    func updateROI(proxy: GeometryProxy) {
        var roi = proxy.frame(in: .global)
        roi.origin.y = 0.0
        
        self.roiFrame = roi
        let screen = UIScreen.main.bounds
        guard screen.width > 0, screen.height > 0 else { return }

        let normalized = CGRect(
            x: 0.0,
            y: roi.origin.x / screen.width,
            width: roi.height / screen.height,
            height: roi.width / screen.width
        )
        cameraManager.setROI(normalizedROI: normalized)
    }

    func delete(at offsets: IndexSet) {
        for index in offsets {
            modelContext.delete(messages[index])
        }
    }
}

struct ROIFrameKey: PreferenceKey {
    static var defaultValue: CGRect = .zero
    static func reduce(value: inout CGRect, nextValue: () -> CGRect) {
        value = nextValue()
    }
}
