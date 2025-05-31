//
//  CameraManager.swift
//  SecretTalker
//
//  Created by 황정현 on 6/1/25.
//

import Foundation
import AVFoundation
import Combine

class CameraManager: NSObject, ObservableObject, AVCaptureMetadataOutputObjectsDelegate {
    let session = AVCaptureSession()
    private var isConfigured = false

    @Published var scannedCode: (code: String, id: UUID)?

    func configure() {
        guard !isConfigured else { return }
        session.beginConfiguration()

        guard
            let device = AVCaptureDevice.default(for: .video),
            let input = try? AVCaptureDeviceInput(device: device),
            session.canAddInput(input)
        else {
            return
        }

        session.addInput(input)

        let output = AVCaptureMetadataOutput()
        if session.canAddOutput(output) {
            session.addOutput(output)
            output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            output.metadataObjectTypes = [.qr]
        }

        session.commitConfiguration()
        
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
                self?.session.startRunning()
            self?.isConfigured = true
        }
    }

    func metadataOutput(_ output: AVCaptureMetadataOutput,
                        didOutput metadataObjects: [AVMetadataObject],
                        from connection: AVCaptureConnection) {
        if let metadata = metadataObjects.first as? AVMetadataMachineReadableCodeObject,
           metadata.type == .qr,
           let code = metadata.stringValue {
            scannedCode = (code: code, id: UUID())
            DispatchQueue.global(qos: .userInitiated).async { [weak self] in
                self?.session.stopRunning()
            }
        }
    }

    func pause() {
        session.stopRunning()
    }

    func resume() {
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
                self?.session.startRunning()
        }
    }
}
