//
//  CameraManager.swift
//  SecretTalker
//
//  Created by 황정현 on 6/1/25.
//

import Foundation
import AVFoundation
import Combine

final class CameraManager: NSObject, ObservableObject, AVCaptureMetadataOutputObjectsDelegate {
    let session = AVCaptureSession()
    private var isConfigured = false
    private var metadataOutput: AVCaptureMetadataOutput?
    
    private let scannedCodeSubject = PassthroughSubject<(code: String, id: UUID), Never>()
    var scannedCodePublisher: AnyPublisher<(code: String, id: UUID), Never> {
        scannedCodeSubject.eraseToAnyPublisher()
    }
    
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
            self.metadataOutput = output
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
            scannedCodeSubject.send((code: code, id: UUID()))
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

extension CameraManager {
    func setROI(previewFrame: CGRect, roiFrame: CGRect) {
        guard let output = metadataOutput else { return }
        
        let x = roiFrame.origin.y / previewFrame.height
        let y = roiFrame.origin.x / previewFrame.width
        let height = roiFrame.height / previewFrame.height
        let width = roiFrame.width / previewFrame.width
        
        let roi = CGRect(x: x, y: y, width: height, height: width)
        output.rectOfInterest = roi
    }
    
    func setROI(normalizedROI: CGRect) {
        guard let output = metadataOutput else { return }
        output.rectOfInterest = normalizedROI
    }
}
