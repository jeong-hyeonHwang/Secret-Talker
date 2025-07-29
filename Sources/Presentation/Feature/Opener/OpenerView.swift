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
    @Environment(\.scenePhase) private var scenePhase
    
    @Query(sort: [SortDescriptor<ScannedSecretMessage>(\.createdDate, order: .reverse)])
    var messages: [ScannedSecretMessage]
    
    @StateObject private var cameraViewModel: CameraViewModel = CameraViewModel()
    @StateObject private var openerViewModel: OpenerViewModel
    
    init(modelContext: ModelContext) {
        _openerViewModel = StateObject(wrappedValue: OpenerViewModel(modelContext: modelContext))
    }
    
    var body: some View {
        GeometryReader { geo in
            VStack(spacing: 4) {
                Spacer(minLength: 4)
                ZStack {
                    GeometryReader { proxy in
                        CameraPreviewView(session: cameraViewModel.session)
                            .onAppear {
                                updateROI(proxy: proxy)
                            }
                            .background(Color.clear)
                    }
                }
                .frame(height: geo.size.height * 0.42)
                .clipped()
                ScannedMessageListView(
                    messages: messages,
                    openerViewModel: openerViewModel
                )
                .frame(height: geo.size.height * 0.58)
            }
            .scrollContentBackground(.hidden)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text(String(localized: "opener_title"))
                        .font(.orbitronTitle)
                }
            }
        }
        .onChange(of: scenePhase) { _, newPhase in
            if newPhase == .active {
                cameraViewModel.resume()
            } else {
                cameraViewModel.pause()
            }
        }
        .onChange(of: cameraViewModel.scannedCode?.id) {
            if let scanned = cameraViewModel.scannedCode {
                openerViewModel.handleScannedCode(scanned.code)
            }
        }
        .sheet(item: $openerViewModel.scannedMessage, onDismiss: {
            if !openerViewModel.isShowingSuccessMessage {
                cameraViewModel.resume()
            }
        }) { message in
            MessageResolverView(
                message: message,
                onSuccess: { decryptedText in
                    Task {
                        cameraViewModel.pause()
                        await MainActor.run {
                            openerViewModel.onDecryptionSuccess(message, decryptedText: decryptedText)
                        }
                    }
                }
            ).environment(\.shapeButtonStyle, ShapeButtonStyle(ratio: 0.7))
        }
        .sheet(item: $openerViewModel.decryptedMessage, onDismiss: {
            cameraViewModel.resume()
        }) { message in
            MessageView(message: message)
        }
    }
}

private extension OpenerView {
    func updateROI(proxy: GeometryProxy) {
        var roi = proxy.frame(in: .global)
        roi.origin.y = 0.0
        
        openerViewModel.setROIFrame(frame: roi)
        
        let screen = UIScreen.main.bounds
        guard screen.width > 0, screen.height > 0 else { return }
        
        let normalized = CGRect(
            x: 0.0,
            y: roi.origin.x / screen.width,
            width: roi.height / screen.height,
            height: roi.width / screen.width
        )
        cameraViewModel.setROI(normalized: normalized)
    }
    
    struct ROIFrameKey: PreferenceKey {
        static var defaultValue: CGRect = .zero
        static func reduce(value: inout CGRect, nextValue: () -> CGRect) {
            value = nextValue()
        }
    }
}
