//
//  CameraViewModel.swift
//  SecretTalker
//
//  Created by 황정현 on 7/23/25.
//

import AVFoundation
import Combine

final class CameraViewModel: ObservableObject {
    private let manager = CameraManager()
    private var cancellables = Set<AnyCancellable>()

    @Published var scannedCode: (id: UUID, code: String)?
    @Published var session: AVCaptureSession

    init() {
        self.session = manager.session
        manager.configure()
        bind()
    }

    private func bind() {
        manager.scannedCodePublisher
            .receive(on: RunLoop.main)
            .sink { [weak self] in self?.scannedCode = $0 }
            .store(in: &cancellables)
    }

    func setROI(normalized: CGRect) {
        manager.setROI(normalizedROI: normalized)
    }

    func pause() { manager.pause() }
    func resume() { manager.resume() }
}
